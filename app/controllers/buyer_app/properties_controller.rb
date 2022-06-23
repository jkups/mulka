module BuyerApp
  class PropertiesController < MainController
    def show
      @property = SellerApp::Property.find_by(id: params[:id])
    end
  end
end
