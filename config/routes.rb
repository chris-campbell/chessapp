Rails.application.routes.draw do

  root 'games#index'

  get '/splash', to: 'pages#splash'

  devise_for :users

  resources :users, only: [:edit, :update, :show]

  resources :games do
    get 'invite', to: 'games#invite_page'
    get "join", to: 'games#join'

    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	put 'move', to: 'pieces#move'
  	 	get 'move', to: 'pieces#move'
    end
  end

  get 'send', to: 'games#send_invite'

  # ActionCable route
  mount ActionCable.server, at: '/cable'

end
