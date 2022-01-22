module UseCases
  module Transactions
    class Update
      include DryCases::Mixin

      step :update_transaction_status
      step :reduce_property_available_units

      def update_transaction_status(data)
        transaction = Transaction.find(data[:transaction_id])
        result = transaction.update(status: Transaction.statuses.fetch(:confirmed))

        result ? Success(transaction) : Failure(transaction)
      end

      def reduce_property_available_units(transaction)
        property_id = transaction.property_id
        property = Property.find(property_id)
        new_available_units = property.available_units - transaction.units

        result = property.update(available_units: new_available_units)
        result ? Success(transaction) : Failure(transaction)
      end
    end
  end
end
