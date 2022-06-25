module SettledProperties
  class RentalIncomeHistoryComponent < ViewComponent::Base
    include ApexChartsHelper

    SERIES_NAME = "rent income".freeze
    CHART_ID = "rent-income-history".freeze
    private_constant :SERIES_NAME, :CHART_ID

    def initialize(property_rents:)
      @property_rents = property_rents
    end

    private

    attr_reader :property_rents

    def series
      [{
        name: SERIES_NAME,
        data: property_rents_data
      }]
    end

    def options
      area_chart_options.merge({id: CHART_ID})
    end

    def property_rents_data
      property_rents.each_with_object({}) { |rent, acc| acc[rent.date] = rent.amount }
    end
  end
end
