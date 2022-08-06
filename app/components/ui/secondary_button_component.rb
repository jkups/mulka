module Ui
  class SecondaryButtonComponent < ViewComponent::Base
    DEFAULT_LINK_BUTTON_CLASS = ["btn secondary"].freeze
    BUTTON_SIZE = {xs: "btn-xs", sm: "btn-sm", md: "btn-md", lg: "btn-lg"}.freeze
    private_constant :DEFAULT_LINK_BUTTON_CLASS

    def initialize(title:, full_width: false, rounded: false, data: {}, classes: nil, size: :md)
      @title = title
      @full_width = full_width
      @rounded = rounded
      @data = data
      @classes = classes
      @size = size
    end

    private

    attr_reader :title, :full_width, :rounded, :data, :classes, :size

    def button_class
      button_class = DEFAULT_LINK_BUTTON_CLASS.dup
      button_class << classes if classes.present?
      button_class << "w-full" if full_width.present?
      button_class << "rounded-full" if rounded.present?
      button_class << BUTTON_SIZE.fetch(size)
      button_class.join(" ")
    end
  end
end
