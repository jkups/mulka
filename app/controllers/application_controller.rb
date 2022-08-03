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
    case resource
    when Buyer then buyer_app_portfolios_path
    when Seller then seller_app_properties_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :buyer then new_buyer_session_path
    when :seller then new_seller_session_path
    else
      root_path
    end
  end
end
