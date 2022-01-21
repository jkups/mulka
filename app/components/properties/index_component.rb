module Properties
  class IndexComponent < ViewComponent::Base
    THUMBNAIL_SIZE = {width: 400, height: 250}.freeze
    private_constant :THUMBNAIL_SIZE

    with_collection_parameter :property

    def initialize(property:)
      @property = property
    end

    private

    attr_reader :property

    def price_per_unit
      number_to_currency(property.listing_price / property.total_units)
    end

    def property_type
      property.property_feature.prop_type
    end

    def thumbnail
      cl_image_tag(
        property.image,
        width: THUMBNAIL_SIZE[:width],
        height: THUMBNAIL_SIZE[:height],
        crop: "fill"
      )
    end
  end
end
