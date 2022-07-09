module Forms
  module SellerApp
    module Properties
      class Create
        include ActiveModel::Model

        attr_reader :name
        attr_reader :description
        attr_reader :image_prefix
        attr_reader :occupied
        attr_reader :category
        attr_reader :classification
        attr_reader :address
        attr_reader :suburb
        attr_reader :subdivision
        attr_reader :country_code
        attr_reader :owner
        attr_reader :organization

        class << self
          def scope
            :properties
          end

          def from_params(params:, owner:)
            kwargs = params[scope].present? ? scoped_atttibutes(params[scope]) : default_attributes
            new(**kwargs.merge({
              owner: owner,
              organization: owner.organization
            }))
          end

          def scoped_attributes(attributes)
            {
              name: attributes[:name],
              description: attributes[:description],
              image_prefix: attributes[:image_prefix],
              occupied: attributes[:occupied],
              category: attributes[:category],
              classification: attributes[:classification],
              address: attributes[:address],
              suburb: attributes[:suburb],
              subdivision: attributes[:subdivision],
              country_code: attributes[country_code]
            }
          end

          def default_attributes
            {
              name: nil,
              description: nil,
              image_prefix: nil,
              occupied: nil,
              category: nil,
              classification: nil,
              address: nil,
              suburb: nil,
              subdivision: nil,
              country_code: nil
            }
          end
        end

        def scope
          self.class.scope
        end

        def initialize(name:, description:, image_prefix:, occupied:, category:, classification:, address:, suburb:, subdivision:, country_code:, owner:, organization:)
          @name = name
          @description = description
          @image_prefix = image_prefix
          @occupied = occupied
          @category = category
          @classification = classification
          @address = address
          @suburb = suburb
          @subdivision = subdivision
          @country_code = country_code
          @owner = owner
          @organization = organization
        end

        def category_options
          ::Properties::Property::CATEGORIES.map do |key, value|
            [value, key]
          end
        end

        def classification_options
          ::Properties::Property::CLASSIFICATIONS.map do |key, value|
            [value, key]
          end
        end

        def yes_no_options
          [
            ["Yes", true],
            ["No", false]
          ]
        end
      end
    end
  end
end
