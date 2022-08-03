module Queries
  module SellerApp
    module Properties
      class FindAll
        include QueryBase

        def query
          ::Properties::Property
            .includes(:offer, :property_feature)
            .all
        end
      end
    end
  end
end
