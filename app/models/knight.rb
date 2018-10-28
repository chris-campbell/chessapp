class Knight < Piece
  
  def valid_move?(x, y)
    
    y_diff = (position_y - y).abs
    x_diff = (position_x - x).abs

    super
    (x_diff) == 2 && (y_diff == 1) || (y_diff) == 2 && (x_diff == 1)
    
  end
  
  
  
end
