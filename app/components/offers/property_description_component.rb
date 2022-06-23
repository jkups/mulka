module Offers
  class PropertyDescriptionComponent < ViewComponent::Base
    def initialize(property:)
      @property = property
    end

    private

    attr_reader :property
  end
end
