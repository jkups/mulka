module Buyers
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    def create
      super

      form = Forms::BuyerApp::Portfolios::Create.from_params(params: build_params, buyer: current_buyer)
      UseCases::BuyerApp::Portfolios::Create.call(form)
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
    end

    private

    def build_params
      {
        portfolio: {
          name: "Default",
          active: true
        }
      }
    end
  end
end
