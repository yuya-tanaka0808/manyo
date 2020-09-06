Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :tasks do
    collection do
      post :confirm
    end
  end
  root to: "tasks#index"
end
