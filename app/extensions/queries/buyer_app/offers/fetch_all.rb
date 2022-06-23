module Queries
  module BuyerApp
    module Offers
      class FetchAll
        include QueryBase

        def query
          Tranzactions::Offer
            .all
            .order(created_at: :asc)
            .includes(:property)
        end
      end
    end
  end
end
