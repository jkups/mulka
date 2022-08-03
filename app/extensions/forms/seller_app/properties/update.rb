module Forms
  module SellerApp
    module Properties
      class Update
        include ActiveModel::Model

        attr_reader :pid
        attr_reader :name
        attr_reader :description
        attr_reader :images
        attr_reader :delete_images
        attr_reader :occupied
        attr_reader :category
        attr_reader :classification
        attr_reader :address
        attr_reader :suburb
        attr_reader :subdivision
        attr_reader :country_code
        attr_reader :bed
        attr_reader :bath
        attr_reader :parking
        attr_reader :plot_size
        attr_reader :floor_size
        attr_reader :property
        attr_reader :owner
        attr_reader :organization

        validates_presence_of :pid,
          :name,
          :description,
          :images,
          :occupied,
          :category,
          :classification,
          :address,
          :suburb,
          :subdivision,
          :country_code,
          :bed,
          :bath,
          :parking,
          :plot_size,
          :floor_size,
          :property,
          :owner,
          :organization

        SUPPORTED_COUNTRIES = ["AU"].freeze
        private_constant :SUPPORTED_COUNTRIES

        class << self
          def scope
            :properties
          end

          def from_params(params:, owner:)
            property = Queries::SellerApp::Properties::FindByOwnerAndId.perform(
              property_id: params[:id],
              owner: owner
            )

            kwargs = params[scope].present? ?
              scoped_attributes(params[scope], property) : default_attributes(property)

            new(**kwargs.merge(organization: owner.organization))
          end

          def scoped_attributes(attributes, property)
            {
              pid: attributes[:pid],
              name: attributes[:name],
              description: attributes[:description],
              images: attributes[:images],
              delete_images: attributes[:deleted_images],
              occupied: attributes[:occupied],
              category: attributes[:category],
              classification: attributes[:classification],
              address: attributes[:address],
              suburb: attributes[:suburb],
              subdivision: attributes[:subdivision],
              country_code: attributes[:country_code],
              bed: attributes[:bed],
              bath: attributes[:bath],
              parking: attributes[:parking],
              plot_size: attributes[:plot_size],
              floor_size: attributes[:floor_size],
              property: property,
              owner: property.owner
            }
          end

          def default_attributes(property)
            {
              pid: property.pid,
              name: property.name,
              description: property.description,
              images: property.images,
              delete_images: nil,
              occupied: property.occupied,
              category: property.category,
              classification: property.classification,
              address: property.address,
              suburb: property.suburb,
              subdivision: property.subdivision,
              country_code: property.country_code,
              bed: property.property_feature.bed,
              bath: property.property_feature.bath,
              parking: property.property_feature.parking,
              plot_size: property.property_feature.plot_size,
              floor_size: property.property_feature.floor_size,
              property: property,
              owner: property.owner
            }
          end
        end

        def scope
          self.class.scope
        end

        def initialize(pid:, name:, description:, organization:, images:, delete_images:, occupied:, category:, classification:, address:, suburb:, subdivision:, country_code:, bed:, bath:, parking:, plot_size:, floor_size:, property:, owner:)
          @pid = pid
          @name = name
          @description = description
          @images = images
          @delete_images = delete_images
          @occupied = occupied
          @category = category
          @classification = classification
          @address = address
          @suburb = suburb
          @subdivision = subdivision
          @country_code = country_code
          @bed = bed
          @bath = bath
          @parking = parking
          @plot_size = plot_size
          @floor_size = floor_size
          @property = property
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

        def supported_countries_options
          SUPPORTED_COUNTRIES.map do |country_code|
            [Country.find_country_by_alpha2(country_code).iso_short_name, country_code]
          end
        end

        def subdivision_options
          selected_country = Country.find_country_by_alpha2(*SUPPORTED_COUNTRIES)
          selected_country.subdivisions.map do |code, data|
            [data["name"], code]
          end
        end

        def file_upload_data
          @upload_data ||= Services::Cloudinary::UploadApi.signed_upload(
            organization: organization
          )
        end

        def property_address
          "#{address}, #{suburb} #{subdivision}, #{country_code}"
        end
      end
    end
  end
end
