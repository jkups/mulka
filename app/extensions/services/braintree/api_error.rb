module Services
  module Braintree
    class ApiError < StandardError
      class << self
        def from_braintree_ruby(e)
          puts e
        end
      end
    end
  end
end
