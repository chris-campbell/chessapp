class PiecesController < ApplicationController
  
  def move
    @piece = Piece.find(params[:piece_id])
    @game = Game.find(params[:game_id])

    color = @piece.color

    x = params[:position_x].to_i
    y = params[:position_y].to_i
    
    # User_turn gets passed in the color just played.
    return false if @piece.user_turn(color)

    if @piece.valid_move?(x, y)
      @piece.capture!(x, y)
      render json: @piece
    else
      false
    end
	end
  #59242mk
  private

  def piece_params
    params.require(:piece).permit(:position_x, :position_y, :game_id)
  end

end
