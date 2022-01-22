module Forms
  module Checkout
    class Create
      include ActiveModel::Model

      attr_reader :nonce,
        :property_id,
        :user_id,
        :name,
        :image,
        :listing_price,
        :number_of_units,
        :available_units,
        :total_units

      validates_presence_of :nonce, :number_of_units
      validate :units_to_acquire_is_available, :nonce_shape_is_accurate

      class << self
        def scope
          :property
        end

        def from_params(params:, user:)
          checkout = params[scope]
          property = Property.find_by!(id: params[:property_id])

          nonce = checkout[:nonce] if checkout.present?
          number_of_units = checkout[:number_of_units].to_i if checkout.present?
          kwargs = prepare_kwargs(property, number_of_units, user)
          new(nonce: nonce, **kwargs)
        end

        def prepare_kwargs(property, number_of_units, user)
          condition = number_of_units.blank? || number_of_units <= 0
          number_of_units = property.minimum_units if condition

          {
            property_id: property.id,
            user_id: user.id,
            name: property.name,
            image: property.image,
            listing_price: property.listing_price,
            number_of_units: number_of_units,
            available_units: property.available_units,
            total_units: property.total_units
          }
        end
      end

      def initialize(nonce:, property_id:, user_id:, name:, image:, listing_price:, number_of_units:, available_units:, total_units:)
        @nonce = nonce
        @property_id = property_id
        @user_id = user_id
        @name = name
        @image = image
        @listing_price = listing_price
        @number_of_units = number_of_units
        @available_units = available_units
        @total_units = total_units
      end

      def scope
        self.class.scope
      end

      def transaction_subtotal
        (listing_price / total_units) * number_of_units
      end

      def transaction_fee
        transaction_subtotal * 0.1
      end

      def transaction_grand_total
        transaction_subtotal + transaction_fee
      end

      def generate_transaction_number
        SecureRandom.hex(3)
      end

      private

      def units_to_acquire_is_available
        return if number_of_units <= available_units

        errors.add(:number_of_units, :units_to_acquire_is_unavailable)
      end

      def nonce_shape_is_accurate
        nonce_prefix = ENV["BRAINTREE_NONCE_PREFIX"]
        return if nonce&.start_with?(nonce_prefix)

        errors.add(:base, :inaccurate_nonce_shape)
      end
    end
  end
end
