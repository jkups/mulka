class Properties::Property < ApplicationRecord
  has_one :property_feature
  has_one :offer, class_name: Tranzactions::Offer.name, foreign_key: "property_id"
  has_one :settled_property
  belongs_to :organization, class_name: Organizations::Organization.name
  belongs_to :owner, class_name: Seller.name
  has_rich_text :description

  CATEGORIES = {
    apartment: "Apartment",
    condo: "Condominium",
    duplex: "Duplex",
    house: "House",
    studio: "Studio",
    terrace: "Terrace",
    town_house: "Town House"
  }.freeze

  CLASSIFICATIONS = {
    off_plan: "Off Plan",
    newly_built: "Newly Built",
    old_building: "Old Building",
    refurbished: "Refurbished"
  }.freeze
end

