Rails.application.routes.draw do
  devise_for :users, class_name: "User"

  resources :portfolios, only: %i[index]
  resources :properties, only: %i[index show] do
    authenticated :user do
      resources :checkout, only: %i[new create]
    end
  end

  unauthenticated do
    match "/properties/*all", to: redirect("/users/sign_in"), via: :all
  end

  root to: redirect("/properties")
end
