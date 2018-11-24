Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'games#index'
   
  resources :games do
    get "join", to: 'games#join'
    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	put 'move', to: 'pieces#move'
  	 	get 'move', to: 'pieces#move'
    end
  end
  mount ActionCable.server, at: '/cable'
end
