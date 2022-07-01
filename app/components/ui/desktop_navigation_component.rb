module Ui
  class DesktopNavigationComponent < ViewComponent::Base
    def initialize(user:)
      @user = user
    end

    private

    attr_reader :user
  end
end
