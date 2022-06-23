module Queries
  module BuyerApp
    module Portfolios
      class FindById
        include QueryBase

        def initialize(portfolio_id:, buyer:)
          @portfolio_id = portfolio_id
          @buyer = buyer
        end

        def query
          Portfolio
            .where(buyer: buyer)
            .find_by!(id: portfolio_id)
        end

        private

        attr_reader :portfolio_id, :buyer
      end
    end
  end
end
