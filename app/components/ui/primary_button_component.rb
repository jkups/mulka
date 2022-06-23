module Ui
  class PrimaryButtonComponent < ViewComponent::Base
    DEFAULT_LINK_BUTTON_CLASS = ["btn primary"].freeze
    private_constant :DEFAULT_LINK_BUTTON_CLASS

    def initialize(title:, full_width: false, rounded: false, data: {}, classes: nil)
      @title = title
      @full_width = full_width
      @rounded = rounded
      @data = data
      @classes = classes
    end

    private

    attr_reader :title, :full_width, :rounded, :data, :classes

    def button_class
      default_link_button_class = DEFAULT_LINK_BUTTON_CLASS.dup
      default_link_button_class << classes if classes.present?
      default_link_button_class << "w-full" if full_width.present?
      default_link_button_class << "rounded-full" if rounded.present?
      default_link_button_class.join(" ")
    end
  end
end
