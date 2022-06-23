class Buyer < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable

  has_many :portfolios, class_name: BuyerApp::Portfolio.name, foreign_key: "buyer_id"
  has_many :expression_of_interests, class_name: BuyerApp::ExpressionOfInterest.name, foreign_key: "buyer_id"
end
