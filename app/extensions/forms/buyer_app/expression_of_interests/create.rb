module Forms
  module BuyerApp
    module ExpressionOfInterests
      class Create
        include ActiveModel::Model

        attr_reader :offer,
          :buyer,
          :name,
          :image,
          :price,
          :minimum_units,
          :number_of_units,
          :available_units,
          :total_units

        validates_presence_of :offer, :buyer, :number_of_units, :minimum_units

        EOI_FEE_PERCENTAGE = BigDecimal("0.1")

        private_constant :EOI_FEE_PERCENTAGE

        class << self
          def scope
            :eoi
          end

          def from_params(params:, buyer:)
            eoi = params[scope]
            offer = Queries::BuyerApp::Offers::FindById.perform(offer_id: params[:offer_id])

            number_of_units = eoi[:number_of_units].to_i if eoi.present?
            kwargs = prepare_kwargs(offer, number_of_units, buyer)
            new(**kwargs)
          end

          def prepare_kwargs(offer, number_of_units, buyer)
            condition = number_of_units.blank? || number_of_units <= 0
            number_of_units = offer.minimum_units if condition

            {
              offer: offer,
              buyer: buyer,
              name: offer.property.name,
              image: offer.property.image,
              price: offer.price,
              minimum_units: offer.minimum_units,
              number_of_units: number_of_units,
              available_units: offer.available_units,
              total_units: offer.total_units
            }
          end
        end

        def initialize(offer:, buyer:, name:, image:, price:, minimum_units:, number_of_units:, available_units:, total_units:)
          @offer = offer
          @buyer = buyer
          @name = name
          @image = image
          @price = price
          @minimum_units = minimum_units
          @number_of_units = number_of_units
          @available_units = available_units
          @total_units = total_units
        end

        def scope
          self.class.scope
        end

        def eoi_subtotal
          (price / total_units) * number_of_units
        end

        def eoi_fee
          eoi_subtotal * EOI_FEE_PERCENTAGE
        end

        def eoi_grand_total
          eoi_subtotal + eoi_fee
        end
      end
    end
  end
end
