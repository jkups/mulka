module Queries
  module BuyerApp
    module Portfolios
      class FindCurrent
        include QueryBase

        def initialize(buyer:)
          @buyer = buyer
        end

        def query
          buyer.portfolios
            .joins(:tranzactions)
            .includes(tranzactions: [:external_reference, {offer: :property}])
            .order(created_at: :desc)
            .current
        end

        private

        attr_reader :buyer
      end
    end
  end
end
