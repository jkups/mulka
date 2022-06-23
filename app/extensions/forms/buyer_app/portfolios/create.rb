module Forms
  module BuyerApp
    module Portfolios
      class Create
        include ActiveModel::Model

        validates_presence_of :name, :number, :active, :buyer

        attr_reader :name, :number, :active, :buyer

        class << self
          def scope
            :portfolio
          end

          def from_params(params:, buyer:)
            portfolio = params[scope]
            new(**prepare_kwargs(portfolio, buyer))
          end

          def prepare_kwargs(portfolio, buyer)
            name = portfolio.fetch(:name)
            active = portfolio.fetch(:active, false)
            portfolio_number = (rand * 10**8).floor

            {
              name: name,
              number: portfolio_number,
              buyer: buyer,
              active: active
            }
          end
        end

        def initialize(name:, buyer:, number:, active:)
          @name = name
          @number = number
          @active = active
          @buyer = buyer
        end
      end
    end
  end
end
