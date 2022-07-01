module SettledProperties
  class SummaryComponent < ViewComponent::Base
    def initialize(settled_property:)
      @settled_property = settled_property
    end

    private

    attr_reader :settled_property, :portfolio

    def portfolio_tranzactions
      portfolio.tranzactions
    end

    def property_status
      settled_property.status.titleize
    end

    def property_lease_term
      settled_property.lease_term.titleize
    end

    def property_lease_end_date
      l(settled_property.lease_end_on, format: :medium)
    end

    def property_manager_company_name
      settled_property.property_manager.company_name
    end

    def property_liaison
      settled_property.liaison.full_name
    end
  end
end
