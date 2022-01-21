module Properties
  class DescriptionComponent < ViewComponent::Base
    def initialize(property:)
      @property = property
    end

    private

    attr_reader :property
  end
end
