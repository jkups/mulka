module SettledProperties
  class RentalAndExpenseLineItems < ViewComponent::Base
    with_collection_parameter :line_item

    def initialize(line_item:)
      @line_item = line_item
    end

    private

    attr_reader :line_item

    def line_item_date
      l(line_item.date, format: :short)
    end

    def line_item_description
      line_item.description
    end

    def line_item_amount
      number_to_currency(line_item.amount)
    end
  end
end
