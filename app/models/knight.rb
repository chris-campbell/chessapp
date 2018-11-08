class Knight < Piece
  
  def valid_move?(x, y)
    y_diff = (position_y - y).abs
    x_diff = (position_x - x).abs

    ((x_diff) == 2 && (y_diff == 1) || (y_diff) == 2 && (x_diff == 1))
    super
  end

end











# def knight_obstructed?(x, y, x_diff, y_diff)
#     if (x_diff) == 2 && (y_diff == 1)
#       return true if (horizontal_obstruct?(x)).eql?(false)
#     elsif (y_diff) == 2 && (x_diff == 1)
#       return true if (vertical_obstruct?(y)).eql?(false)
#     else
#       false
#     end
#   end