class Buyer < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable

  validates :full_name, :email, :password, presence: true, on: :create
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, on: :create

  has_many :portfolios, class_name: Portfolios::Portfolio.name, foreign_key: "buyer_id"
  has_many :expression_of_interests, class_name: Tranzactions::ExpressionOfInterest.name, foreign_key: "buyer_id"
end
