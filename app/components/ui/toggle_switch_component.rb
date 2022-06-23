module Ui
  class ToggleSwitchComponent < ViewComponent::Base
    def initialize(background_color: "bg-green-500")
      @background_color = background_color
    end

    private

    attr_reader :background_color

    def border_color
      background_color.gsub("bg", "border")
    end
  end
end
