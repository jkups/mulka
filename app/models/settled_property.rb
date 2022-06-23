class SettledProperty < ApplicationRecord
  belongs_to :property, class_name: SellerApp::Property.name
  belongs_to :property_manager
  has_many :property_expenses
  has_many :property_rents
  has_many :property_valuations

  enum status: [:occupied, :vacant], _suffix: true
end
