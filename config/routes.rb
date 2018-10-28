Rails.application.routes.draw do
  
  devise_for :users
  root 'static_pages#index'
  
  resources :games do
    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	get 'move', to: 'games#move'
    end
  end
  
end
