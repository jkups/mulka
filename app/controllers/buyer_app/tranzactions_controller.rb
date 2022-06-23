module BuyerApp
  class TranzactionsController < MainController
    def new
      @tranzaction = Forms::BuyerApp::Tranzactions::Create.from_params(
        params: params,
        buyer: current_buyer
      )
    end

    def create
      @tranzaction = Forms::BuyerApp::Tranzactions::Create.from_params(
        params: params,
        buyer: current_buyer
      )

      result = UseCases::BuyerApp::Tranzactions::Create.call(@tranzaction)

      if result.success?
        redirect_to buyer_app_offer_tranzactions_success_path(offer_id: @tranzaction.offer.id)
      else
        redirect_to buyer_app_offer_tranzactions_failure_path(offer_id: @tranzaction.offer.id)
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
