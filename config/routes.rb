Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :matches
  root "matches#index"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy] do
    collection do
      get "users_index"
    end
  end
  resources :teams, only: [:edit, :update, :new, :create, :destroy] do
    delete "/remove_user/:user_id", to: "teams#remove_user"
    post "/add_user/:user_id", to: "teams#add_user"
  end
  resources :tournaments do
    collection do
      get "types"
    end
    post "/add_team", to: "tournaments#add_team"
  end
  resources :games, only: [:index]
end
