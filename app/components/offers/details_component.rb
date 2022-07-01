module Offers
  class DetailsComponent < ViewComponent::Base
    def initialize(offer:)
      @offer = offer
    end

    private

    attr_reader :offer

    def eoi_offer?
      offer.expression_of_interest_status?
    end

    def sold_out?
      offer.sold_out_status?
    end

    def property_image_path
      cl_image_path(offer.property.image)
    end

    def property_image
      content_tag(
        :div, "",
        class: "h-96 bg-cover bg-no-repeat",
        style: "background-image: url(#{property_image_path})"
      )
    end

    def property_unit_price
      unit_price = number_to_currency(offer.price / offer.total_units)
      t(".unit_price", unit_price: unit_price)
    end

    def property_type
      offer.property.category
    end

    def property_status
      offer.status.titleize
    end

    def property_value
      number_to_currency(offer.price)
    end

    def units_available
      number_with_delimiter(offer.available_units)
    end

    def minimum_investment
      t(".minimum_unit", minimum_unit: offer.minimum_units)
    end

    def estimated_yield
      number_to_percentage(5, precision: 0)
    end
  end
end
