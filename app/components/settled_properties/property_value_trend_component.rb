module SettledProperties
  class PropertyValueTrendComponent < ViewComponent::Base
    include ApexChartsHelper

    SERIES_NAME = "proeprty value".freeze
    CHART_ID = "property-value-trend".freeze
    private_constant :SERIES_NAME, :CHART_ID

    def initialize(settled_property:)
      @settled_property = settled_property
    end

    private

    attr_reader :settled_property

    def property_values
      settled_property.property_valuations
    end

    def series
      [{
        name: SERIES_NAME,
        data: property_values_data
      }]
    end

    def property_values_data
      property_values.each_with_object({}) { |value, acc| acc[value.date] = value.estimate }
    end

    def options
      area_chart_options.merge({id: CHART_ID})
    end
  end
end
