module BuyerApp
  class PropertiesController < MainController
    def show
      @property = Properties::Property.find_by(id: params[:id])
    end
  end
end
