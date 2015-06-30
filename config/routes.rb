Rails.application.routes.draw do
  root to: 'forms#meet_and_greet'

  resources :form_drafts, only: [:edit, :new, :show, :update] do
    member do
      post :remove_field
    end
  end

  resources :forms, only: [:index, :show, :update] do
    collection do
      get  :meet_and_greet # ROOT
    end
    member do
      post :submit
      get  :thank_you
    end
  end

  resources :sessions, only: [:new] do
    collection do
      get    :dev_login
      post   :dev_login
      delete :destroy
    end
  end
end
