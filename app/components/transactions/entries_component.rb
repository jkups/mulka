module Transactions
  class EntriesComponent < ViewComponent::Base
    with_collection_parameter :transaction_entry

    def initialize(transaction_entry:)
      @transaction_entry = transaction_entry
    end

    private

    attr_reader :transaction_entry

    def transaction_date
      transaction_entry.created_at.strftime("%d/%m/%Y")
    end

    def transaction_number
      transaction_entry.trxn_number.upcase
    end

    def value_subtotal
      number_to_currency(transaction_entry.value)
    end

    def fee_subtotal
      number_to_currency(transaction_entry.fee)
    end

    def units_acquired
      number_with_delimiter(transaction_entry.units)
    end
  end
end
