module Offers
  class IndexComponent < ViewComponent::Base
    THUMBNAIL_SIZE = {width: 400, height: 250}.freeze
    private_constant :THUMBNAIL_SIZE

    with_collection_parameter :offer

    def initialize(offer:)
      @offer = offer
    end

    private

    attr_reader :offer

    def price_per_unit
      number_to_currency(offer.price / offer.total_units)
    end

    def property_type
      offer.property.category
    end

    def thumbnail
      cl_image_tag(
        offer.property.image,
        width: THUMBNAIL_SIZE[:width],
        height: THUMBNAIL_SIZE[:height],
        crop: "fill"
      )
    end
  end
end
