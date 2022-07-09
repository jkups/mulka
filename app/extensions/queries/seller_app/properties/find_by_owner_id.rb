module Queries
  module SellerApp
    module Properties
      class FindByOwnerId
        include QueryBase

        def initialize(owner:)
          @owner = owner
        end

        def query
          ::Properties::Property
            .includes(:offer, :property_feature)
            .where(owner: owner)
        end

        private

        attr_reader :owner
      end
    end
  end
end
