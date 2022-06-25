module SettledProperties
  class ExpenseHistoryComponent < ViewComponent::Base
    include ApexChartsHelper

    SERIES_NAME = "rent income".freeze
    CHART_ID = "rent-expense-history".freeze
    private_constant :SERIES_NAME, :CHART_ID

    def initialize(property_expenses:)
      @property_expenses = property_expenses
    end

    private

    attr_reader :property_expenses

    def series
      [{
        name: SERIES_NAME,
        data: property_expenses_data
      }]
    end

    def property_expenses_data
      property_expenses.each_with_object({}) { |expense, acc| acc[expense.date] = expense.amount }
    end

    def options
      area_chart_options.merge({id: CHART_ID})
    end
  end
end
