module SettledProperties
  class PropertyValueTrendComponent < ViewComponent::Base
    include ApexChartsHelper

    def initialize
    end

    def series
      [
        {name: "rent income", data: {"1999": 23000, "2000": 35000, "2010": 45000}}
      ]
    end

    def options
      area_chart_options.merge({id: "property-value-trend"})
    end
  end
end
