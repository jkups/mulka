module Ui
  class PrimaryLinkButtonComponent < ViewComponent::Base
    DEFAULT_LINK_BUTTON_CLASS = ["btn primary"].freeze
    BUTTON_SIZE = {xs: "btn-xs", sm: "btn-sm", md: "btn-md", lg: "btn-lg"}.freeze
    private_constant :DEFAULT_LINK_BUTTON_CLASS

    def initialize(title:, href:, full_width: false, rounded: false, size: :md)
      @title = title
      @href = href
      @full_width = full_width
      @rounded = rounded
      @size = size
    end

    private

    attr_reader :title, :href, :full_width, :rounded, :size

    def button_class
      button_class = DEFAULT_LINK_BUTTON_CLASS.dup
      button_class << "w-full" if full_width.present?
      button_class << "rounded-full" if rounded.present?
      button_class << BUTTON_SIZE.fetch(size)
      button_class.join(" ")
    end
  end
end
