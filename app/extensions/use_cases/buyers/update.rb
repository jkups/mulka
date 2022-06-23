module UseCases
  module Buyers
    class Update
      include DryCases::Mixin

      check :valid?
      step :persist_buyer

      private

      def valid?(form)
        form.valid?
      end

      def persist_buyer(form)
        buyer_update_succeed = form.buyer.update(
          preferred_name: form.preferred_name,
          email: form.email,
          mobile_number: form.mobile_number,
          address: form.address,
          suburb: form.suburb,
          city: form.city,
          country: form.country
        )

        buyer_update_succeed ? Success(form) : Failure(form)
      end
    end
  end
end
