module Properties
  class TableComponent < ViewComponent::Base
    def initialize(properties:)
      @properties = properties
    end

    private

    attr_reader :properties
  end
end
