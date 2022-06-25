module Queries
  module BuyerApp
    module SettledProperty
      class FindByPortfolioAndPropertyId
        include QueryBase

        def initialize(portfolio_id:, property_id:)
          @portfolio_id = portfolio_id
          @property_id = property_id
        end

        def query
          ::Portfolios::PortfolioSettledProperty
            .includes(:settled_property)
            .joins(settled_property: [:property_rents, :property_expenses, :property_valuations, :property_manager])
            .where(settled_property: {property_id: property_id})
            .find_by(portfolio_id: portfolio_id)
        end

        private

        attr_reader :portfolio_id, :property_id
      end
    end
  end
end
