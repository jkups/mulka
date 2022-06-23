class Buyer < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable

  has_many :portfolios, class_name: Portfolios::Portfolio.name, foreign_key: "buyer_id"
  has_many :expression_of_interests, class_name: Tranzactions::ExpressionOfInterest.name, foreign_key: "buyer_id"
end
