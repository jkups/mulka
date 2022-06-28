module BuyerApp
  class MainController < ApplicationController
    layout "buyer_app/main"

    def redirect_on_no_referrer
      redirect_to buyer_app_root_path if request.referrer.blank?
    end
  end
end
