module Services
  module SendGrid
    module Templates
      class Welcome
        def initialize(to:, name:, subject:)
          @to = to
          @name = name
          @subject = subject
        end

        def data
          # implement dynamic template data
        end

        def identifier
          # set template id
        end

        attr_reader :to, :subject, :name
      end
    end
  end
end
