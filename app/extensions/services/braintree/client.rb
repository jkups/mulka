module Services
  module Braintree
    class Client
      def initialize(nonce:, config: Braintree::Config.params)
        @nonce = nonce
        @client = ::Braintree::Gateway.new(**config)
      end

      def pay(total_amount:, trxn_reference: nil)
        client.transaction.sale!(
          amount: total_amount.to_s,
          payment_method_nonce: nonce,
          options: {submit_for_settlement: true},
          custom_fields: {trxn_reference: trxn_reference}
        )
      rescue ::Braintree::ValidationsFailed => e
        raise Braintree::ApiError.from_braintree_ruby(
          e
        )
      end

      private

      attr_reader :nonce, :client
    end
  end
end
