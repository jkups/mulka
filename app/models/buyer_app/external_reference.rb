module BuyerApp
  class ExternalReference < ApplicationRecord
    has_one :tranzaction
  end
end
