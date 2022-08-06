Rails.application.routes.draw do
  devise_for :admins
  devise_for :buyers, controllers: {registrations: "buyers/registrations"}
  devise_for :sellers

  authenticated :buyer do
    namespace :buyer_app do
      root to: redirect("/buyer_app/portfolios")
      resource :profiles, only: %i[show update]
      resources :portfolios, only: %i[index] do
        resources :settled_properties, only: %i[show]
      end
      resources :offers, only: %i[index show] do
        resources :tranzactions, only: %i[new create]
        resources :expression_of_interests, only: %i[new create]
        get "tranzactions/success", to: "tranzactions#success"
        get "tranzactions/failure", to: "tranzactions#failure"
        get "expression_of_interests/success", to: "expression_of_interests#success"
        get "expression_of_interests/failure", to: "expression_of_interests#failure"
      end
    end
  end

  authenticated :seller do
    namespace :seller_app do
      root to: redirect("/seller_app/properties")
      resources :properties, except: %i[show destroy]
      resources :offers, except: %i[show destroy]
    end
  end

  unauthenticated :buyer do
    match "/buyer_app/*all", to: redirect("/buyers/sign_in"), via: :all
  end

  unauthenticated :seller do
    match "/seller_app/*all", to: redirect("/sellers/sign_in"), via: :all
  end

  root to: redirect("/buyers/sign_in")
end
