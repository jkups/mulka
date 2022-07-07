module Services
  module Email
    class ApiError < StandardError
      class << self
        def from_send_grid_ruby(e)
          Bugsnag.notify(e)
        end
      end
    end
  end
end
