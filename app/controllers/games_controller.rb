class GamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @games = current_user.games 
    games = Game.all
    @joined = games.reject do |game|
      game.black_id != current_user.id
    end
  end

  def new
    @game = Game.new
  end

  def after_sign_up_path
    redirect_to games_path
  end

  def create
    @game = current_user.games.create!(game_create_params)
    @game.white_id = current_user.id
    @game.save
    if @game.valid?
      redirect_to game_path(@game)
    else
      redirect_to root_path, alert: 'Could not create game.'
    end
  end

  def join
    @game = Game.find(params[:game_id])
      if @game
        current_pieces = @game.friendly_pieces('black')
        current_pieces.each do |piece|
          if @game.black_id.nil?
            piece.update_attributes(player: current_user.id)
          end
        end
      end
    @game.black_id = current_user.id
    @game.save
    render :show
  end
  
  def invite_page
    @game = Game.find(params[:game_id])
  end

  def show
    @game = Game.find(params[:id])
  end

  # Send invitation to opposing player 
  def send_invite
    @game = current_user.games.last.id
    @user = current_user.games.last
    @info = { email: params[:invite_email], name: params[:name], game_id: @game, user: @user.user  }
    # InvitationMailer.send_invitation(@info).deliver
  end


  private

  def game_create_params
    params.require(:game).permit(:name, :email, :user_id, :white_id, :black_id,
    :turn, :user_id, :winner_id)
  end

end
