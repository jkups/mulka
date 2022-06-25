module SettledProperties
  class RentalAndExpenseHistoryComponent < ViewComponent::Base
    def initialize(settled_property:)
      @settled_property = settled_property
    end

    private

    attr_reader :settled_property
  end
end
