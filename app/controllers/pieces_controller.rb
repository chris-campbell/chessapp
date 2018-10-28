class PiecesController < ApplicationController
  
  def move
      @piece = Piece.find(:piece_id)
  end
  
  private
  
  def piece_params
    params.require(:piece).permit(:position_x, :position_y, :game_id)
  end
   
end
  
  
  
  
  
    # if false
    # # render status: 200, json: {valid: true}
    # else
    # flash[:notice] = "Invalid move"
    # end
        
    # respond_to do |format|
    #   debugger
    #   format.js
    #   format.html

    # end