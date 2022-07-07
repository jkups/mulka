module Services
  module Email
    module Templates
      class InvestmentConfirmation < Base
        TEMPLATE_ID = "d-7729b2e5d2ae4488a11a405244b5352c".freeze
        private_constant :TEMPLATE_ID

        def data
          {
            name: name,
            subject: subject
          }
        end

        def identifier
          TEMPLATE_ID
        end
      end
    end
  end
end
