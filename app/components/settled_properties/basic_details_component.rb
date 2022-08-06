module SettledProperties
  class BasicDetailsComponent < ViewComponent::Base
    THUMBNAIL_SIZE = 200
    private_constant :THUMBNAIL_SIZE

    def initialize(property:)
      @property = property
    end

    private

    attr_reader :property

    def property_image_url
      first_property_image = property.images.split(",").first
      cl_image_path(first_property_image, width: THUMBNAIL_SIZE, crop: "fill")
    end

    def property_image
      content_tag(:div, "",
        class: "h-16 w-16 bg-[percentage:250%_auto] bg-no-repeat",
        style: "background-image: url('#{property_image_url}')"
      )
    end
  end
end
