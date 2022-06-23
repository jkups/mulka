class Properties::SettledProperty < ApplicationRecord
  belongs_to :property
  belongs_to :property_manager
  has_many :property_expenses
  has_many :property_rents
  has_many :property_valuations
  has_many :portfolio_settled_properties, class_name: Portfolios::PortfolioSettledProperty.name, foreign_key: "settled_property_id"
  has_many :portfolios, through: :portfolio_settled_properties

  enum status: [:occupied, :vacant], _suffix: true
end
