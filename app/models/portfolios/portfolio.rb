class Portfolios::Portfolio < ApplicationRecord
  belongs_to :buyer
  has_many :tranzactions, class_name: Tranzactions::Tranzaction.name, foreign_key: "portfolio_id"
  has_many :portfolio_settled_properties
  has_many :settled_properties, through: :portfolio_settled_properties

  scope :current, -> { find_by(active: true) }
end
