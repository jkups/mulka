class ApplicationController < ActionController::Base
  # Scan for N+1 queries in development
  if Rails.env.development?
    before_action do
      Prosopite.scan
    end

    after_action do
      Prosopite.finish
    end
  end

  def after_sign_in_path_for(resource)
    portfolios_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
