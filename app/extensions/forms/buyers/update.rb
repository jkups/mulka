module Forms
  module Buyers
    class Update
      include ActiveModel::Model

      validates_presence_of :buyer, :full_name, :email, :mobile_number, :address, :suburb, :country

      attr_reader :buyer,
        :full_name,
        :preferred_name,
        :email,
        :mobile_number,
        :address,
        :suburb,
        :city,
        :country

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
            city: buyer.city,
            country: buyer.country
          }
        end

        def scoped_kwargs(params, buyer)
          scoped_profile = params[scope]
          preferred_name = scoped_profile[:preferred_name].blank? ? nil : scoped_profile[:preferred_name]
          city = scoped_profile[:city].blank? ? nil : scoped_profile[:city]

          {
            full_name: buyer.full_name,
            preferred_name: preferred_name,
            email: scoped_profile[:email],
            mobile_number: scoped_profile[:mobile_number],
            address: scoped_profile[:address],
            suburb: scoped_profile[:suburb],
            city: city,
            country: scoped_profile[:country]
          }
        end
      end

      def initialize(buyer:, full_name:, preferred_name:, email:, mobile_number:, address:, suburb:, city:, country:)
        @buyer = buyer
        @full_name = full_name
        @preferred_name = preferred_name
        @email = email
        @mobile_number = mobile_number
        @address = address
        @suburb = suburb
        @city = city
        @country = country
      end

      def scope
        self.class.scope
      end
    end
  end
end
