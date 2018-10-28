class Bishop < Piece

  def valid_move?(x, y)
    (position_x - x).abs == (position_y - y).abs
    super
  end
  
end