module SettledProperties
  class RentalIncomeHistoryComponent < ViewComponent::Base
    include ApexChartsHelper

    def initialize
    end

    def series
      today = Date.today
      result = {}
      20.downto(1) do |i|
        new_date = today - i * 50
        result[new_date] = 1629
      end

      [{name: "rent income", data: result}]
    end

    def options
      area_chart_options.merge({id: "rent-income-history"})
    end
  end
end
