class Properties::Property < ApplicationRecord
  has_one :property_feature
  has_one :offer, class_name: Tranzactions::Offer.name, foreign_key: "property_id"
  has_one :settled_property
  belongs_to :organization, class_name: Organizations::Organization.name

  enum classification: [:off_plan, :newly_built, :existing, :refurbished], _suffix: true
end

