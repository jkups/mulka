module Properties
  class DetailsComponent < ViewComponent::Base
    def initialize(property:)
      @property = property
    end

    private

    attr_reader :property

    def property_image_path
      cl_image_path(property.image)
    end

    def property_image
      tag(
        :div,
        class: "h-96 bg-cover bg-no-repeat",
        style: "background-image: url(#{property_image_path})"
      )
    end

    def property_unit_price
      unit_price = number_to_currency(property.listing_price / property.total_units)
      t(".unit_price", unit_price: unit_price)
    end

    def property_type
      property.property_feature.prop_type
    end

    def property_status
      property.status.titleize
    end

    def property_value
      number_to_currency(property.listing_price)
    end

    def units_available
      number_with_delimiter(property.available_units)
    end

    def minimum_investment
      t(".minimum_unit", minimum_unit: property.minimum_units)
    end

    def estimated_yield
      number_to_percentage(5, precision: 0)
    end
  end
end
