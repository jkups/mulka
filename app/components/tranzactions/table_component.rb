module Tranzactions
  class TableComponent < ViewComponent::Base
    def initialize(prepared_tranzactions:)
      @prepared_tranzactions = prepared_tranzactions
    end

    private

    attr_reader :prepared_tranzactions
  end
end
