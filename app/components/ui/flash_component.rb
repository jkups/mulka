module Ui
  class FlashComponent < ViewComponent::Base
    BASE_CLASS = ["inline-block text-white px-4 py-2 rounded-full"].freeze
    ICON = {alert: "fa-ban", notice: "fa-check-circle"}.freeze
    private_constant :BASE_CLASS, :ICON

    def initialize(type:, message:)
      @type = type
      @message = message
    end

    private

    attr_reader :type, :message

    def flash_class
      base_class = BASE_CLASS.dup
      base_class << "bg-green-500" if type == :notice
      base_class << "bg-red-500" if type == :alert
      base_class.join(" ")
    end

    def flash_icon
      ICON.dig(type)
    end
  end
end
