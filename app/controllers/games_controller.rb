class GamesController < ApplicationController
	before_action :authenticate_user!

	def index
		@games = Game.all
	end

	def new 
		@game = Game.new
	end

	def create
		@game = current_user.games.create(game_create_params)
		if @game.valid?
			redirect_to game_path(@game)
		else
			redirect_to root_path, alert: "Could not create game."
		end
	end

	def show
		@game = Game.find(params[:id])
	end
	
	def repopulate_board
	  @game = Game.find(params[:id])
	  @game.pieces.destroy_all
	  @game.populate_board
	  render 'show'
	end
	
	def move
    @piece = Piece.find(params[:piece_id])
   
    x = params[:position_x].to_i
    y = params[:position_y].to_i
  
    
    if @piece.valid_move?(x, y)
      @piece.capture!(x, y)
      render json: @piece
    else
      false
    end
    #   if @piece.capturable?(x, y)
    #     @piece.update_captured_piece!(x, y)
    #     render json: @piece
 
      
    #   elsif !@piece.capturable?(x, y) 
    #     @piece.update_attributes(position_x: x, position_y: y)
    #     render json: @piece
    #   end
    # else
    #   return false

	end
  
	private

	def piece_params
		params.require(:piece).permit(:piece_id, :position_x, :position_y)
	end

	def game_create_params
		params.require(:game).permit(:name, :email)
	end

end

