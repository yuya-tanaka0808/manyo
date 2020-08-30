Rails.application.routes.draw do
  resources :tasks do
    collection do
      post :confirm
    end
  end
  root to: "tasks#index"
end
