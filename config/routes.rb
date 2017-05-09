Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'find_administrative_divisions', to: 'country_state#find_administrative_divisions'
  resources :profiles, only: [:show, :edit, :update] do
    resources :psa_histories, only: [:index]
  end
  resources :topics, only: [:create, :new, :index, :show] do
    resources :posts, except: [:index, :destroy] do
      member do
        patch :delete
      end
      resources :comments, except: [:index, :destroy] do
        member do 
          patch :delete
        end
      end
    end
  end
end
