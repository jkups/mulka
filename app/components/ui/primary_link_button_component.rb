module Ui
  class PrimaryLinkButtonComponent < ViewComponent::Base
    DEFAULT_LINK_BUTTON_CLASS = ["btn primary"]
    private_constant :DEFAULT_LINK_BUTTON_CLASS

    def initialize(title:, href:, full_width: false, rounded: false)
      @title = title
      @href = href
      @full_width = full_width
      @rounded = rounded
    end

    private

    attr_reader :title, :href, :full_width, :rounded

    def button_class
      DEFAULT_LINK_BUTTON_CLASS << " w-full" if full_width.present?
      DEFAULT_LINK_BUTTON_CLASS << " rounded-full" if rounded.present?
      DEFAULT_LINK_BUTTON_CLASS.join
    end
  end
end
