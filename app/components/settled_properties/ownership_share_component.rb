module SettledProperties
  class OwnershipShareComponent < ViewComponent::Base
    include ApexChartsHelper

    SERIES_NAME = "you own".freeze
    CHART_ID = "ownership-share".freeze
    private_constant :SERIES_NAME, :CHART_ID

    def initialize(portfolio_settled_property:, settled_property:)
      @portfolio_settled_property = portfolio_settled_property
      @settled_property = settled_property
    end

    private

    attr_reader :portfolio_settled_property, :settled_property

    def series
      [
        {
          name: SERIES_NAME,
          data: ownership_percentage
        }
      ]
    end

    def options
      radial_chart_options.merge({id: CHART_ID})
    end

    def ownership_percentage
      (portfolio_settled_property.units / total_property_offer_unit) * 100
    end

    def total_property_offer_unit
      settled_property.offer.total_units
    end

    def monthly_rent
      number_to_currency(settled_property.monthly_rent)
    end

    def rental_income_to_date
      number_to_currency(settled_property.property_rents.sum(&:amount))
    end

    def current_property_value
      number_to_currency(settled_property.property_valuations.max_by(&:date).estimate)
    end
  end
end
