module Queries
  module SellerApp
    module Properties
      class FindByOwnerAndId
        include QueryBase

        def initialize(owner:, property_id:)
          @owner = owner
          @property_id = property_id
        end

        def query
          ::Properties::Property
            .includes(:property_feature)
            .find_by(id: property_id, owner: owner)
        end

        private

        attr_reader :owner, :property_id
      end
    end
  end
end
