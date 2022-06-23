module BuyerApp
  class ProfilesController < MainController
    def show
      @form = Forms::Buyers::Update.from_params(
        params: params,
        buyer: current_buyer
      )
    end

    def update
      @form = Forms::Buyers::Update.from_params(
        params: params,
        buyer: current_buyer
      )

      result = UseCases::Buyers::Update.call(@form)

      if result.success?
        flash[:notice] = "Profile update was successful."
        redirect_to buyer_app_profiles_path
      else
        render :show
      end
    end
  end
end
