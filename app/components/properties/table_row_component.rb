module Properties
  class TableRowComponent < ViewComponent::Base
    THUMBNAIL_SIZE = {width: 80}.freeze
    NO_OFFERS = "no offers".freeze
    OFFER_STATUS_COLOR = {
      inactive: "text-amber-100 bg-amber-500",
      active: "text-green-100 bg-green-500",
      sold_out: "text-gray-100 bg-gray-500",
      expression_of_interest: "text-blue-100 bg-blue-500",
      no_offers: "text-red-100 bg-red-500"
    }.with_indifferent_access.freeze

    private_constant :THUMBNAIL_SIZE, :OFFER_STATUS_COLOR, :NO_OFFERS

    with_collection_parameter :property

    def initialize(property:, property_counter:)
      @property = property
      @property_counter = property_counter
    end

    private

    attr_reader :property, :property_counter

    def property_name
      property.name
    end

    def property_address
      "#{property.address}, #{property.suburb} #{property.subdivision}, #{property.country_code}"
    end

    def property_category
      property.category
    end

    def property_offer_status
      return NO_OFFERS unless property.offer.present?
      property.offer.status.humanize.downcase
    end

    def property_thumbnail
      first_image = property.images.split(",").first

      cl_image_tag(
        first_image,
        width: THUMBNAIL_SIZE[:width],
        crop: "fill"
      )
    end

    def offer_status_color
      return OFFER_STATUS_COLOR.fetch(:no_offers) unless property.offer.present?
      OFFER_STATUS_COLOR.fetch(property.offer.status)
    end
  end
end
