module UseCases
  module BuyerApp
    module Tranzactions
      class Create
        include DryCases::Mixin

        map :accumulator
        map :build_external_reference
        map :build_tranzaction
        check :valid?

        around :db_transaction, with: "db_transaction" # execute subsequent steps in a transaction
        tee :lock_offer
        check :payment_processed?
        step :persist_external_reference
        step :persist_tranzaction
        step :reduce_offer_available_units
        tee :send_investment_confirmation

        Accumulator = Struct.new(:form, :tranzaction, :external_reference, keyword_init: true)

        private

        def accumulator(form)
          Accumulator.new(form: form)
        end

        def build_external_reference(accumulator)
          form = accumulator.form

          external_reference = ::Tranzactions::ExternalReference.new(
            referenceable_source: form.payment_method,
            referenceable_id: form.generate_tranzaction_reference
          )

          Accumulator.new(**accumulator.to_h, external_reference: external_reference)
        end

        def build_tranzaction(accumulator)
          form = accumulator.form

          tranzaction = ::Tranzactions::Tranzaction.new(
            units: form.number_of_units,
            amount: form.tranzaction_subtotal,
            fee: form.tranzaction_fee,
            offer: form.offer,
            portfolio: form.portfolio
          )

          Accumulator.new(**accumulator.to_h, tranzaction: tranzaction)
        end

        def valid?(accumulator)
          accumulator.form.valid?
        end

        def lock_offer(accumulator)
          accumulator.form.offer.lock!
        end

        def payment_processed?(accumulator)
          form = accumulator.form
          nonce_prefix = ENV["BRAINTREE_NONCE_PREFIX"]
          nonce = form.nonce.gsub(nonce_prefix, "")

          client = Services::Payment::Client.new(nonce: nonce)

          client.pay(
            total_amount: form.tranzaction_grand_total,
            trxn_reference: form.generate_tranzaction_reference
          ).present?
        end

        def persist_external_reference(data)
          data.external_reference.save ? Success(data) : Failure(data)
        end

        def persist_tranzaction(data)
          data.tranzaction.external_reference = data.external_reference
          data.tranzaction.save ? Success(data) : Failure(data)
        end

        def reduce_offer_available_units(data)
          offer = data.form.offer
          new_available_units = offer.available_units - data.tranzaction.units

          result = offer.update(available_units: new_available_units)
          result ? Success(data) : Failure(data)
        end

        def send_investment_confirmation(data)
          ::BuyerApp::InvestmentConfirmationJob.perform_later(
            tranzaction_id: data.tranzaction.id
          )
        end
      end
    end
  end
end
