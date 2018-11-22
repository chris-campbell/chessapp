class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def move
    @piece = Piece.find(params[:piece_id])
    @game = Game.find(params[:game_id])
    color = @piece.color
    x = params[:position_x].to_i
    y = params[:position_y].to_i

    if @piece.player == current_user.id
      if @piece.valid_move?(x, y)
        
        @piece.capture!(x, y)
        if @piece
          return false if @piece.update_turn(color)
          
          ActionCable.server.broadcast 'piece_channel', position_x:  x,
                      position_y: y, color: color,
                      player: @piece.player, piece_id: @piece.id,
                      turn: @game.opposite_color(@game.turn)
        # @game.stalemate?(@game.opposite_color(@game.turn))
        end
        
      else
        false
      end
    end
	end

  private

  def piece_params
    params.require(:piece).permit(:position_x, :position_y, :game_id)
  end

end
