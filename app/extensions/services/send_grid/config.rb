module Services
  module SendGrid
    class Config
      class << self
        def params
          {
            api_key: ENV["SENDGRID_API_KEY"]
          }
        end
      end
    end
  end
end
