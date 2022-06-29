module Services
  module SendGrid
    class ApiError < StandardError
      class << self
        def from_send_grid_ruby(e)
          puts e
        end
      end
    end
  end
end
