class Offer < ApplicationRecord
  belongs_to :property, class_name: SellerApp::Property.name
  has_many :tranzactions, class_name: BuyerApp::Tranzaction.name, foreign_key: "offer_id"
  has_many :expression_of_interests, class_name: BuyerApp::ExpressionOfInterest.name, foreign_key: "offer_id"

  enum status: [:inactive, :active, :sold_out], _suffix: true
end
