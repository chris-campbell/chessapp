Rails.application.routes.draw do
  root 'games#index'
  
  get '/splash', to: 'pages#splash'
  
  devise_for :users

  resources :users, only: [:edit, :update, :show]
  
  resources :games do
    get "join", to: 'games#join'
    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	put 'move', to: 'pieces#move'
  	 	get 'move', to: 'pieces#move'
    end
  end

  resources :games, except: :destroy do
    resource :invitations, only: [:new, :create, :show]
  end
  
  # ActionCable route
  mount ActionCable.server, at: '/cable'
end
