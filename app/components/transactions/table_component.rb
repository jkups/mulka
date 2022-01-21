module Transactions
  class TableComponent < ViewComponent::Base
    def initialize(prepared_transactions:)
      @prepared_transactions = prepared_transactions
    end

    private

    attr_reader :prepared_transactions
  end
end
