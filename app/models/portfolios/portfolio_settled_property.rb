class Portfolios::PortfolioSettledProperty < ApplicationRecord
  belongs_to :portfolio
  belongs_to :settled_property, class_name: Properties::SettledProperty.name
end
