module SettledProperties
  class OwnershipShareComponent < ViewComponent::Base
    include ApexChartsHelper

    def initialize
    end

    def series
      [
        {name: "you own", data: 20}
      ]
    end

    def options
      radial_chart_options.merge({id: "ownership-share"})
    end
  end
end
