module Queries
  module BuyerApp
    module Properties
      class FindById
        include QueryBase

        def initialize(property_id:)
          @property_id = property_id
        end

        def query
          ::Properties::Property.find_by!(id: property_id)
        end

        private

        attr_reader :property_id
      end
    end
  end
end
