Rails.application.routes.draw do
  
  devise_for :users
  root 'games#index'
  
  resources :games do
    # member do
    #   get 'repopulate_board', path: ""
    # end
    resources :pieces, only: [:new, :create, :show, :index]  do
  	 	get 'move', to: 'pieces#move'
    end
  end
  
end
