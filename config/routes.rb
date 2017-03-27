Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  resources :profiles, only: [:show, :edit, :update] do
    resources :psa_histories, only: [:index]
  end
  resources :topics, only: [:create, :new, :index]
end

