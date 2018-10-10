class Pawn < Piece

  # Determines if pawn is making a valid
  def valid_move?(x, y)
    # If forward move is true than valid_move? is True
    forward_move?(y_diff(y)) ? true : false
    super
  end
  
  def valid_enpassant_move?(x, y)
    return true if valid_enpassant_black?(x, y) || valid_enpassant_white?(x, y)
    return false if invalid_enpassant_black?(x, y) || invalid_enpassant_white?(x, y)
  end
  
  def valid_enpassant_white?(x, y)
    return false unless white?
    (position_x + 1).eql?(x) && (position_y + 1).eql?(y) ||
    (position_x - 1).eql?(x) && (position_y + 1).eql?(y)
  end
  
  def valid_enpassant_black?(x, y)
    return false unless black?
    (position_x + 1).eql?(x) && (position_y - 1).eql?(y) ||
    (position_x - 1).eql?(x) && (position_y - 1).eql?(y)
  end
  
  def invalid_enpassant_black?(x, y)
    return false unless black?
    (position_x + 1).eql?(x) && (position_y + 1).eql?(y) ||
    (position_x - 1).eql?(x) && (position_y + 1).eql?(y) 
  end
  
  def invalid_enpassant_white?(x, y)
    return false unless white?
    (position_x + 1).eql?(x) && (position_y - 1).eql?(y) ||
    (position_x - 1).eql?(x) && (position y - 1).eql?(y)
  end
  
  def enpassant_capturable?
  end
  
  def y_diff(y)
    # Gives the difference between on current coordinate to new coordinate.
    y_diff = (y - position_y).abs if white?
    y_diff = (position_y - y).abs if black?
  end

  # # Pawn's Special capture move
  def en_passant(x, y)
 
  end
  
  # Adds double
  def perform_double_jump!(x, y)
    if y_diff(y).eql?(2) && start_position? 
      move_to!(x, y)
      update_attributes(special: 'double_jumped')
    else
      update_attributes(special: nil)
    end
  end

  def double_jumped?
    special.eql?('double_jumped') ? true : false
  end

  # Checks if forward move is possible
  def forward_move?(y_diff)
    y_diff.eql?(2) && start_position? || y_diff.eql?(1)
  end

  # Determines if it's the pawn first move
  def start_position?
    position_y.eql?(1) && white? || position_y.eql?(6) && black?
  end

  # Checks to see if pawn is promotable
  def promotable?
    (color.eql?('black') && position_y.eql?(0) || color.eql?('white') && position_y.eql?(7))
  end

  # Updates database to reflect a pawn's promotion (changes db)
  def promote!(x, y)
   return false unless promotable?
   pawn_piece = present_piece(x, y)
   pawn_piece.update_attributes(type: 'Queen', special: 'promoted')
  end

end
