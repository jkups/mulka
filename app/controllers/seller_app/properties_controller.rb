module SellerApp
  class PropertiesController < MainController
    def index
      # @properties = Queries::SellerApp::Properties::FindAll.perform
      @properties = Queries::SellerApp::Properties::FindByOwner.perform(
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
      @form = Forms::SellerApp::Properties::Create.from_params(
        params: params,
        owner: current_seller
      )

      result = UseCases::SellerApp::Properties::Create.call(@form)

      if result.success?
        flash[:success] = "Property was successfully created"
        redirect_to seller_app_properties_path
      else
        render :new
      end
    end

    def edit
      @form = Forms::SellerApp::Properties::Update.from_params(
        params: params,
        owner: current_seller
      )
    end

    def update
      @form = Forms::SellerApp::Properties::Update.from_params(
        params: params,
        owner: current_seller
      )

      result = UseCases::SellerApp::Properties::Update.call(@form)

      if result.success?
        flash[:success] = "Property was successfully updated"
        redirect_to seller_app_properties_path
      else
        render :edit
      end
    end
  end
end
