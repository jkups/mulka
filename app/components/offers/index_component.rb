module Offers
  class IndexComponent < ViewComponent::Base
    OFFER_STATUS_COLOR = {
      active: "text-white bg-green-500",
      sold_out: "text-white bg-gray-500",
      expression_of_interest: "text-white bg-amber-500"
    }.with_indifferent_access.freeze

    THUMBNAIL_SIZE = {width: 400, height: 250}.freeze

    private_constant :THUMBNAIL_SIZE, :OFFER_STATUS_COLOR

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

    def offer_status_color
      OFFER_STATUS_COLOR.fetch(offer.status)
    end

    def offer_status
      offer.status.humanize.downcase
    end

    def thumbnail_url
      cl_image_path(offer.property.image_prefix)
    end

    def thumbnail
      content_tag(:div, "",
        class: "h-44 bg-no-repeat bg-cover",
        style: "background-image: url('#{thumbnail_url}')"
      )
    end
  end
end
