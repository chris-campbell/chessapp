Rails.application.routes.draw do
  root 'pages#splash'
  devise_for :users, controllers: { registrations: "registrations" }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :games do
    get "join", to: 'games#join'
    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	put 'move', to: 'pieces#move'
  	 	get 'move', to: 'pieces#move'
    end
  end
  mount ActionCable.server, at: '/cable'
end
