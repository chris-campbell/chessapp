class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update]
    before_action :check_authorization, only: [:edit, :update]
    before_action :set_user
    
    def show
      # :set_user
    end
    
    def edit
      # :set_user
    end
    
    def update
      # :set_user
      if @user.update(user_params)
        redirect_to @user
      else
        flash.now[:alert] = "Something went wrong. Please try again."
        render :edit
      end
    end
    
    private
        
    def check_authorization
      current_user.id == params[:id]
    end
    
    def set_user
       @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:email, :avatar, :username)
    end
end