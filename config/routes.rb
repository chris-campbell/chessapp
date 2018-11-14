Rails.application.routes.draw do
  
  devise_for :users
  root 'games#index'
  
  resources :games do
    get 'join', to: 'games#join'
    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	get 'move', to: 'pieces#move'
    end
  end
  mount ActionCable.server, at: '/cable'
end
