module SettledProperties
  class BasicDetailsComponent < ViewComponent::Base
    THUMBNAIL_SIZE = 80
    private_constant :THUMBNAIL_SIZE

    def initialize(property:)
      @property = property
    end

    private

    attr_reader :property

    def property_image
      cl_image_tag(property.image, width: THUMBNAIL_SIZE, crop: "fill")
    end
  end
end
