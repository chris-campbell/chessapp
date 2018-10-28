class Pawn < Piece

  # Determines if pawn is making a valid
  def valid_move?(x, y)
    forward_move?(y_diff(y))
    super
  end
  
  def valid_enpassant_move?(x, y)
    valid_enpassant_black?(x, y) || valid_enpassant_white?(x, y)
  end
  
  def valid_enpassant_white?(x, y)
    (position_x + 1).eql?(x) && (position_y + 1).eql?(y) ||
    (position_x - 1).eql?(x) && (position_y + 1).eql?(y)
  end
  
  def valid_enpassant_black?(x, y)
    (position_x + 1).eql?(x) && (position_y - 1).eql?(y) ||
    (position_x - 1).eql?(x) && (position_y - 1).eql?(y)
  end

  def enpassant_piece_type(y)
    x1 = position_x - 1
    x2 = position_x + 1
    
    piece_exists?(position_x: x1, position_y: y) ? x = x1 : x = x2
    piece = game.pieces.find_by(position_x: x, position_y: y)
    piece.type == "Pawn"
  end
  
  def enpassant_piece_present_at?(y)
    x1 = position_x - 1
    x2 = position_x + 1
    enpassant_exists?(x1, x2, y)
  end
  
  def enpassant_exists?(x1, x2, y)
    game.pieces.exists?(position_x: x1, position_y: y) ||
    game.pieces.exists?(position_x: x2, position_y: y)
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
    if valid_enpassant_move?(x, y)
      
      if piece_present_at?(left, right)
        if type_pawn && !same_color(right) && double_jumped?
          enpassant_capture!
        end
      end
    end
  end
  
  # Adds double
  def perform_double_jump!(x, y)
    if y_diff(y).eql?(2) && start_position? 
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
    start_position? && y_diff.eql?(2) || y_diff.eql?(1)
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
