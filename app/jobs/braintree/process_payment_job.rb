module Braintree
  class ProcessPaymentJob < ApplicationJob
    def perform(transaction_id:, nonce:)
      transaction = ::Transaction.find(transaction_id)
      client = Services::Braintree::Client.new(nonce: nonce)

      total_amount = transaction.value + transaction.fee
      result = client.pay_with_paypal(total_amount: total_amount)

      if result.present?
        UseCases::Transactions::Update.call(transaction_id: transaction.id)
      end
    end
  end
end
