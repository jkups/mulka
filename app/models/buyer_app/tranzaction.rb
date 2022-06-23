module BuyerApp
  class Tranzaction < ApplicationRecord
    belongs_to :offer
    belongs_to :portfolio
    belongs_to :external_reference

    # enum status: {pending: 0, confirmed: 1}, _suffix: true
  end
end
