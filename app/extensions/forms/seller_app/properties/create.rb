module Forms
  module SellerApp
    module Properties
      class Create
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
        attr_reader :owner
        attr_reader :organization

        validates_presence_of :pid,
          :description,
          :name,
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
          :owner,
          :organization

        SUPPORTED_COUNTRIES = ["AU"].freeze
        private_constant :SUPPORTED_COUNTRIES

        class << self
          def scope
            :properties
          end

          def from_params(params:, owner:)
            kwargs = params[scope].present? ? scoped_attributes(params[scope]) : default_attributes
            new(**kwargs.merge(owner: owner, organization: owner.organization))
          end

          def scoped_attributes(attributes)
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
              floor_size: attributes[:floor_size]
            }
          end

          def default_attributes
            {
              pid: SecureRandom.hex(8),
              name: nil,
              description: nil,
              images: nil,
              delete_images: nil,
              occupied: nil,
              category: nil,
              classification: nil,
              address: nil,
              suburb: nil,
              subdivision: nil,
              country_code: nil,
              bed: nil,
              bath: nil,
              parking: nil,
              plot_size: nil,
              floor_size: nil
            }
          end
        end

        def scope
          self.class.scope
        end

        def initialize(pid:, name:, description:, images:, delete_images:, occupied:, category:, classification:, address:, suburb:, subdivision:, country_code:, owner:, organization:, bed:, bath:, parking:, plot_size:, floor_size:)
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
      end
    end
  end
end
