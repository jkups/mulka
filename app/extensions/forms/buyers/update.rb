module Forms
  module Buyers
    class Update
      include ActiveModel::Model

      validates_presence_of :buyer, :full_name, :email, :mobile_number, :address, :subdivision, :country_code
      validates :mobile_number, phone: true

      attr_reader :buyer,
        :full_name,
        :preferred_name,
        :email,
        :mobile_number,
        :address,
        :suburb,
        :subdivision,
        :country_code

      SUPPORTED_COUNTRIES = ["AU"].freeze
      private_constant :SUPPORTED_COUNTRIES

      class << self
        def scope
          :profile
        end

        def from_params(params:, buyer:)
          kwargs = params[scope].present? ? scoped_kwargs(params, buyer) : default_kwargs(buyer)
          new(buyer: buyer, **kwargs)
        end

        def default_kwargs(buyer)
          {
            full_name: buyer.full_name,
            preferred_name: buyer.preferred_name,
            email: buyer.email,
            mobile_number: buyer.mobile_number,
            address: buyer.address,
            suburb: buyer.suburb,
            subdivision: buyer.subdivision,
            country_code: buyer.country_code
          }
        end

        def scoped_kwargs(params, buyer)
          scoped_profile = params[scope]
          preferred_name = scoped_profile[:preferred_name].blank? ? nil : scoped_profile[:preferred_name]
          subdivision = scoped_profile[:subdivision].blank? ? nil : scoped_profile[:subdivision]

          {
            full_name: buyer.full_name,
            preferred_name: preferred_name,
            email: scoped_profile[:email],
            mobile_number: scoped_profile[:mobile_number],
            address: scoped_profile[:address],
            suburb: scoped_profile[:suburb],
            subdivision: subdivision,
            country_code: scoped_profile[:country_code]
          }
        end
      end

      def initialize(buyer:, full_name:, preferred_name:, email:, mobile_number:, address:, suburb:, subdivision:, country_code:)
        @buyer = buyer
        @full_name = full_name
        @preferred_name = preferred_name
        @email = email
        @mobile_number = mobile_number
        @address = address
        @suburb = suburb
        @subdivision = subdivision
        @country_code = country_code
      end

      def scope
        self.class.scope
      end

      def telephone_supported_countries
        supported_countries_options.map { |_, code| code }
      end

      def supported_countries_options
        SUPPORTED_COUNTRIES.map do |country_code|
          [Country.find_country_by_alpha2(country_code).iso_short_name, country_code]
        end
      end

      def subdivision_options
        return [["---", nil]] if country_code.blank?

        selected_country = Country.find_country_by_alpha2(country_code)
        selected_country.subdivisions.map do |_, data|
          [data["name"], data["name"]]
        end
      end
    end
  end
end
