module BuyerApp
  class ExpressionOfInterestsController < MainController
    # before_action :redirect_on_no_referrer, only: %i[success failure]

    def new
      @form = Forms::BuyerApp::ExpressionOfInterests::Create.from_params(
        params: params,
        buyer: current_buyer
      )
    end

    def create
      @form = Forms::BuyerApp::ExpressionOfInterests::Create.from_params(
        params: params,
        buyer: current_buyer
      )

      result = UseCases::BuyerApp::ExpressionOfInterests::Create.call(@form)

      if result.success?
        redirect_to buyer_app_offer_expression_of_interests_success_path(offer_id: @form.offer.id)
      else
        redirect_to buyer_app_offer_expression_of_interests_failure_path(offer_id: @form.offer.id)
      end
    end

    def success
      @offer = Queries::BuyerApp::Offers::FindById.perform(
        offer_id: params[:offer_id]
      )
    end

    def failure
      @offer = Queries::BuyerApp::Offers::FindById.perform(
        offer_id: params[:offer_id]
      )
    end
  end
end
