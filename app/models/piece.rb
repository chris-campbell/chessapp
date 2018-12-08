class Piece < ApplicationRecord

  belongs_to :game

  # Captures present piece if is capturable (changes db)
  def capture!(x, y)
    if capturable?(x, y) # piece present and same color
      # Update the captured piece
      update_captured_piece!(x, y)
      # Update the capturing piece
      move_to!(x, y)
    else
      move_to!(x, y)
    end
  end

  def present_piece(x, y)
    game.pieces.find_by(position_x: x, position_y: y)
  end

  # Changes captured piece attributes to reflect capture (changes db)
  def update_captured_piece!(x, y)
    present_piece(x, y).update_attributes(position_x: 8, position_y: 8, dead: true)
  end

  # Updates a piece location based on given coordinates (changes db)
  def move_to!(x, y)
    update_attributes(position_x: x, position_y: y)
  end

  # Checks if a piece is present at given location.
  def piece_present_at?(x, y)
    game.pieces.exists?(position_x: x, position_y: y)
  end

  # Checks if pieces have same color
  def same_color?(x, y)
    game.pieces.find_by(position_x: x, position_y: y).color == color
  end

  def piece_exists?(x, y)
    game.pieces.exists?(position_x: x, position_y: y)
  end

  # Determines if a piece can be captured
  def capturable?(x, y)
    piece_present_at?(x, y) && !same_color?(x, y)
  end

  # Determine if space has a piece present and isn't nil
  def obstruction_present?(x, y)
    game.pieces.find_by(position_x: x, position_y: y).nil?
  end

  # Determines if Piece color is black
  def black?
    color.eql?('black')
  end

  # Determines if Piece color is white
  def white?
    color.eql?('white')
  end

  # Checks checks for horizontal obstruction
  def horizontal_obstruct?(x)
    if position_x < x
      (position_x + 1).upto(x - 1) do |x|
        return true if square_occupied?(x, position_y)
      end
    elsif position_x > x
      (position_x - 1).downto(x + 1) do |x|
        return true if square_occupied?(x, position_y)
      end
    end
    false
  end

  # Checks for vertical obstruction
  def vertical_obstruct?(y)
    if position_y < y
      (position_y + 1).upto(y - 1) do |y|
       return true if square_occupied?(position_x, y)
      end
    elsif position_y > y
      (position_y - 1).downto(y + 1) do |y|
        return true if square_occupied?(position_x, y)
      end
    end
    false
  end

  # Checks for diagonal_obstruction
  def diagonal_obstruct?(x, y)
    if position_x < x
      ((position_x + 1)...x).each do |intermediate_x|
        y_change = intermediate_x - position_x
        intermediate_y = y > position_y ? position_y + y_change : position_y - y_change
        return true if square_occupied?(intermediate_x, intermediate_y)
      end
    elsif position_x > x
      ((x + 1)...position_x).each do |intermediate_x|
        y_change = position_x - intermediate_x
        intermediate_y = y > position_y ? position_y + y_change : position_y - y_change
        return true if square_occupied?(intermediate_x, intermediate_y)
      end
    end
    false
  end
  
  # Returns opposite color
  def opposite_color(color)
    color.eql?('white') ? 'black' : 'white'
  end

  # Checks if square is occupied
  def square_occupied?(x, y)
    game.pieces.exists?(position_x: x, position_y: y)
  end
  
  # Determine move direction
  def examine_path(x, y)
    if position_y == y
      'horizontal'
    elsif position_x == x
      'vertical'
    elsif (y - position_y).abs == (x - position_x).abs
      'diagonal'
    end
  end

  # Checks the path based on provided coodinates for obstruction
  def obstructed?(x, y)
    path = examine_path(x, y)
    case path
    when 'horizontal'
      horizontal_obstruct?(x)
    when 'vertical'
      vertical_obstruct?(y)
    when 'diagonal'
      diagonal_obstruct?(x, y)
    else
      return false
    end
  end

  # Checks if pieces is still in same position
  def same_position?(x, y)
    (position_x == x && position_y == y)
  end

  # Check if a square is occupied
  def occupied?(x, y)
    piece_present_at?(x, y) && same_color?(x, y)
  end

  def update_turn(color)
    if game.turn == color
      new_color = color == 'white' ? 'black' : 'white'
      game.update_attributes(turn: new_color)
      false
    else
      true
    end
  end

  # Determines if a pieces move is valid
  def valid_move?(x, y)
    # As long as these stay false return true
    if (off_the_board?(x, y) || obstructed?(x, y) || same_position?(x, y) || occupied?(x, y)).eql?(false)
      true
    else
      false
    end
  end

  # Determines if piece is being moved off board
  def off_the_board?(x, y)
    x < 0 || y < 0 || x > 7 || y > 7 || x.nil? || y.nil?
  end

end
