module UseCases
  module Transactions
    class Create
      include DryCases::Mixin

      check :valid?
      map :accumulator
      map :build_transaction
      step :persist_transaction
      tee :queue_payment_processing

      Accumulator = Struct.new(:form, :transaction, keyword_init: true)

      private

      def valid?(form)
        form.valid?
      end

      def accumulator(form)
        Accumulator.new(form: form)
      end

      def build_transaction(accumulator)
        form = accumulator.form

        transaction = Transaction.new(
          units: form.number_of_units,
          value: form.transaction_subtotal,
          fee: form.transaction_fee,
          trxn_number: form.generate_transaction_number,
          property_id: form.property_id,
          user_id: form.user_id
        )

        Accumulator.new(form: form, transaction: transaction)
      end

      def persist_transaction(data)
        transaction = data.transaction
        transaction.save ? Success(data) : Failure(data.form)
      end

      def queue_payment_processing(data)
        nonce_prefix = ENV["BRAINTREE_NONCE_PREFIX"]
        nonce = data.form.nonce.gsub(nonce_prefix, "")

        Braintree::ProcessPaymentJob.perform_later(
          transaction_id: data.transaction.id,
          nonce: nonce
        )
      end
    end
  end
end
