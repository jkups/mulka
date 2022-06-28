module BuyerApp
  class TranzactionsController < MainController
    def new
      @form = Forms::BuyerApp::Tranzactions::Create.from_params(
        params: params,
        buyer: current_buyer
      )
    end

    def create
      @form = Forms::BuyerApp::Tranzactions::Create.from_params(
        params: params,
        buyer: current_buyer
      )

      result = UseCases::BuyerApp::Tranzactions::Create.call(@form)

      if result.success?
        redirect_to buyer_app_offer_tranzaction_success_path(offer_id: @form.offer.id)
      else
        redirect_to buyer_app_offer_tranzaction_failure_path(offer_id: @form.offer.id)
      end
      # if result.success?
      #   flash[:notice] = "Transaction was successful."
      #   redirect_path = url_for(action: :index, controller: :portfolios, tranzaction_id: result.value!.tranzaction.id, offer_id: result.value!.tranzaction.offer_id)

      #   redirect_to redirect_path
      # else
      #   flash[:alert] = "Something went wrong."
      #   redirect_to buyer_app_root_path
      # end
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
