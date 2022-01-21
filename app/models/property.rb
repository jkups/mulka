class Property < ApplicationRecord
  has_one :property_feature
  has_many :transactions

  enum status: [:inactive, :active, :sold_out], _suffix: true
end
