class Tranzactions::Offer < ApplicationRecord
  belongs_to :property, class_name: Properties::Property.name
  has_many :tranzactions
  has_many :expression_of_interests

  enum status: [:inactive, :active, :sold_out], _suffix: true
end
