module BuyerApp
  class OffersController < MainController
    def index
      @offers = Queries::BuyerApp::Offers::FetchAll.perform({})
    end

    def show
      @offer = Queries::BuyerApp::Offers::FindById.perform(
        offer_id: params[:id]
      )
    end
  end
end
