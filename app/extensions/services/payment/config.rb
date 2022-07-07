module Services
  module Payment
    class Config
      class << self
        def params
          {
            environment: :sandbox,
            merchant_id: ENV["BRAINTREE_MERCHANT_ID"],
            public_key: ENV["BRAINTREE_PUBLIC_KEY"],
            private_key: ENV["BRAINTREE_PRIVATE_KEY"]
          }
        end
      end
    end
  end
end
