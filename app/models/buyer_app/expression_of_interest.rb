module BuyerApp
  class ExpressionOfInterest < ApplicationRecord
    belongs_to :offer
    belongs_to :buyer
  end
end
