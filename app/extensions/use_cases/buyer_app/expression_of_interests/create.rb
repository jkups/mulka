module UseCases
  module BuyerApp
    module ExpressionOfInterests
      class Create
        include DryCases::Mixin

        check :valid?
        step :persist_expression_of_interest

        private

        def valid?(form)
          form.valid?
        end

        def persist_expression_of_interest(form)
          eoi = ::Tranzactions::ExpressionOfInterest.new(
            offer: form.offer,
            buyer: form.buyer,
            units: form.number_of_units
          )

          eoi.save ? Success(form) : Failure(form)
        end
      end
    end
  end
end
