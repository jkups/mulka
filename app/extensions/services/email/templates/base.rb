module Services
  module Email
    module Templates
      class Base
        DEFAULT_FROM_EMAIL = "support@webtail.com".freeze

        def initialize(to:, name:, subject:)
          @to = to
          @name = name
          @subject = subject
        end

        def from
          DEFAULT_FROM_EMAIL
        end

        def data
          raise NotImplementedError # child class must implement this method
        end

        def identifier
          raise NotImplementedError # child class must implement this method
        end

        attr_reader :to, :subject, :name
      end
    end
  end
end
