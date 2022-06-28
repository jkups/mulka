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

    def property_name
      offer.property.name
    end

    def property_address
      offer.property.address
    end

    def offer_status
      offer.status.humanize.downcase
    end

    def thumbnail_url
      cl_image_path(offer.property.image)
    end

    def thumbnail
      content_tag(:div, "",
        class: "h-44 bg-no-repeat bg-cover",
        style: "background-image: url('#{thumbnail_url}')"
      )
    end
  end
end
