module UseCases
  module BuyerApp
    module Portfolios
      class Create
        include DryCases::Mixin

        check :valid?
        step :persist_portfolio

        private

        def valid?(form)
          form.valid?
        end

        def persist_portfolio(form)
          portfolio = ::Portfolios::Portfolio.new(
            name: form.name,
            number: form.number,
            buyer: form.buyer,
            active: form.active
          )

          portfolio.save ? Success(form) : Failure(form)
        end
      end
    end
  end
end
