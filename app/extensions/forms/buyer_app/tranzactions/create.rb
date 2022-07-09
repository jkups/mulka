module Forms
  module BuyerApp
    module Tranzactions
      class Create
        include ActiveModel::Model

        attr_reader :nonce,
          :offer,
          :portfolio,
          :name,
          :image,
          :price,
          :minimum_units,
          :number_of_units,
          :available_units,
          :total_units,
          :payment_method

        validates_presence_of :nonce, :payment_method, :number_of_units, :minimum_units
        validate :units_to_acquire_is_available, :nonce_shape_is_valid

        TRANZACTION_FEE_PERCENTAGE = BigDecimal("0.1")

        private_constant :TRANZACTION_FEE_PERCENTAGE

        class << self
          def scope
            :tranzaction
          end

          def from_params(params:, buyer:)
            tranzaction = params[scope]
            offer = Queries::BuyerApp::Offers::FindById.perform(offer_id: params[:offer_id])

            nonce = tranzaction[:nonce] if tranzaction.present?
            payment_method = tranzaction[:payment_method] if tranzaction.present?
            number_of_units = tranzaction[:number_of_units].to_i if tranzaction.present?
            kwargs = prepare_kwargs(offer, number_of_units, buyer)
            new(nonce: nonce, payment_method: payment_method, **kwargs)
          end

          def prepare_kwargs(offer, number_of_units, buyer)
            condition = number_of_units.blank? || number_of_units <= 0
            number_of_units = offer.minimum_units if condition

            {
              offer: offer,
              portfolio: buyer.portfolios.current,
              name: offer.property.name,
              image: offer.property.image_prefix,
              price: offer.price,
              minimum_units: offer.minimum_units,
              number_of_units: number_of_units,
              available_units: offer.available_units,
              total_units: offer.total_units
            }
          end
        end

        def initialize(nonce:, payment_method:, offer:, portfolio:, name:, image:, price:, minimum_units:, number_of_units:, available_units:, total_units:)
          @nonce = nonce
          @offer = offer
          @portfolio = portfolio
          @name = name
          @image = image
          @price = price
          @payment_method = payment_method
          @minimum_units = minimum_units
          @number_of_units = number_of_units
          @available_units = available_units
          @total_units = total_units
        end

        def scope
          self.class.scope
        end

        def tranzaction_subtotal
          (price / total_units) * number_of_units
        end

        def tranzaction_fee
          tranzaction_subtotal * TRANZACTION_FEE_PERCENTAGE
        end

        def tranzaction_grand_total
          tranzaction_subtotal + tranzaction_fee
        end

        def generate_tranzaction_reference
          @tranzaction_reference ||= SecureRandom.hex(3)
        end

        private

        def units_to_acquire_is_available
          return if number_of_units <= available_units

          errors.add(:number_of_units, :units_to_acquire_is_unavailable)
        end

        def nonce_shape_is_valid
          nonce_prefix = ENV["BRAINTREE_NONCE_PREFIX"]
          return if nonce&.start_with?(nonce_prefix)

          errors.add(:base, :inaccurate_nonce_shape)
        end

        # TODO: units_to_acquire_is_not_higher_than_half
      end
    end
  end
end
