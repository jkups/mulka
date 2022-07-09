module BuyerApp
  class SettledPropertiesController < MainController
    def show
      @portfolio_settled_property = Queries::BuyerApp::SettledProperty::FindByPortfolioAndPropertyId.perform(
        portfolio_id: params[:portfolio_id],
        property_id: params[:id]
      )

      @property = Queries::BuyerApp::Properties::FindById.perform(property_id: params[:id])
    end
  end
end
