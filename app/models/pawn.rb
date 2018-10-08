class Pawn < Piece

  # Determines if pawn is making a valid
  def valid_move?(x, y)

    # Checks the difference between on current coordinate to new coordinate
    y_diff = (y - position_y).abs if white?
    y_diff = (position_y - y).abs if black?

    # If forward move is true than valid_move? is True
    forward_move?(y_diff) ? true : false
    super
  end
  
  # Pawn's Special capture move
  def en_passant(x, y)
  end

  def double_jump_performed?(x, y)
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
