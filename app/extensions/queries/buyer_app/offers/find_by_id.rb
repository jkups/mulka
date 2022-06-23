module Queries
  module BuyerApp
    module Offers
      class FindById
        include QueryBase

        def initialize(offer_id:)
          @offer_id = offer_id
        end

        def query
          Offer
            .includes(:property)
            .find_by!(id: offer_id)
        end

        private

        attr_reader :offer_id
      end
    end
  end
end
