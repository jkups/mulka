module SettledProperties
  class ExpenseHistoryComponent < ViewComponent::Base
    include ApexChartsHelper

    def initialize
    end

    def series
      today = Date.today
      result = {}
      20.downto(1) do |i|
        new_date = today - i * 50
        result[new_date] = (rand * 10000).floor
      end

      [{name: "rent income", data: result}]
    end

    def options
      area_chart_options.merge({id: "expense-history"})
    end
  end
end
