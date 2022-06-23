module BuyerApp
  class Portfolio < ApplicationRecord
    belongs_to :buyer
    has_many :tranzactions

    scope :current, -> { find_by(active: true) }
  end
end
