module Offers
  class PropertyImagesComponent < ViewComponent::Base
    renders_many :property_images, -> (image_url:) do
      tag(:img, src: cl_image_path(image_url), size: "150x150")
    end
  end
end
