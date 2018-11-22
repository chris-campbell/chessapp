class GamesController < ApplicationController
	before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
	def index
		@games = Game.all
	end

	def new
		@game = Game.new
	end

	def create
	  @game = current_user.games.create!(game_create_params)
    @game.white_id = current_user.id
    @game.save
		if @game.valid?
			redirect_to game_path(@game)
		else
			redirect_to root_path, alert: "Could not create game."
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
	  redirect_to @game
	end

	def show
		@game = Game.find(params[:id])
	end

	private

	def game_create_params
		params.require(:game).permit(:name, :email, :user_id, :white_id, :black_id, :turn, :user_id, :winner_id)
	end

end

