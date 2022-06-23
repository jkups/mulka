module SellerApp
  class Property < ApplicationRecord
    has_one :property_feature
    has_one :offer, foreign_key: "property_id"
    has_one :settled_property, foreign_key: "property_id"
    belongs_to :organization

    enum classification: [:off_plan, :newly_built, :existing, :refurbished], _suffix: true
  end
end
