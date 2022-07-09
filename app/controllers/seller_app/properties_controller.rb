module SellerApp
  class PropertiesController < MainController
    def index
      # @properties = Queries::SellerApp::Properties::FindAll.perform
      @properties = Queries::SellerApp::Properties::FindByOwnerId.perform(
        owner: current_seller
      )
    end

    def show
    end

    def new
      @form = Forms::SellerApp::Properties::Create.from_params(
        params: params,
        owner: current_seller
      )
    end

    def create
    end

    def edit
    end

    def update
    end
  end
end
