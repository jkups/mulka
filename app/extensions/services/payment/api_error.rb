module Services
  module Payment
    class ApiError < StandardError
      class << self
        def from_braintree_ruby(e)
          Bugsnag.notify(e)
        end
      end
    end
  end
end
