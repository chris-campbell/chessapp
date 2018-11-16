class Game < ApplicationRecord

  belongs_to :user
  has_many :pieces, :dependent => :destroy
  
  validates :name, presence: true
  after_create :populate_board
  
  self.inheritance_column = :type
  scope :bishops, -> { where(type: "Bishop") }
  scope :kings,   -> { where(type: "King") }
  scope :knights, -> { where(type: "Knight") }
  scope :queens,  -> { where(type: "Queen") }
  scope :pawns,   -> { where(type: "Pawn") }
  scope :rooks,   -> { where(type: "Rook") }

  def stalemate?(color)
    current_pieces = friendly_pieces(color)
    possible_moves = []
    current_pieces.each do |piece|
      8.times do |x|
        8.times do |y|
          possible_moves << [x, y] if piece.valid_move?(x, y)
        end
      end
    end
    return false if possible_moves.any?
    true
  end
  
  def determine_color(color)
    color == 'black' ? 'white' : 'black'
  end
  
  def friendly_pieces(color)
    team_color = color == 'black' ? 'black' : 'white'
    pieces.where(color: team_color)
  end
  
  def in_check?(king)
    opposite_pieces = pieces.where(color: !king.color)
    opposite_pieces.each do |piece|
      if piece.valid_move?(king.position_x, king.position_y)
        return true
      else
        return false
      end
    end
  end
  
	# Will determine if move of friendly piece will cause check 
  def put_in_check?(target_x, target_y)
    current_state = false
    ActiveRecord::Base.transaction do
      move_friendly_piece(target_x, target_y)
      current_state = king.where(color: king.color).in_check?
      raise ActiveRecord::Rollback
    end
    reload
    current_state
  end  
  
  # The Moving of a friendly piece
  def move_friendly_piece(x,y)
    update_attributes(position_x: x, position_y: y)
  end
  
	def populate_board
	  self.update_attributes(turn: 'white')
	  puts  "This is the id: #{self.user_id}" 
  	# Populates white pieces in the database
    (0..7).each do |p|
      Pawn.create(game_id: id, type: 'Pawn', player: user_id, color: 'white', position_x: p, position_y: 1)
    end
    
    Rook.create(game_id: id, type: 'Rook', player: user_id, color:'white', position_x: 0, position_y: 0)
    Rook.create(game_id: id, type: 'Rook', player: user_id, color:'white', position_x: 7, position_y: 0)
  
    Knight.create(game_id: id, type: 'Knight', player: user_id,  color: 'white', position_x: 1, position_y: 0)
    Knight.create(game_id: id, type: 'Knight', player: user_id, color: 'white', position_x: 6, position_y: 0)
  
  
    Bishop.create(game_id: id, type: 'Bishop', player: user_id, color: 'white', position_x: 2, position_y: 0)
    Bishop.create(game_id: id, type: 'Bishop',  player: user_id, color: 'white', position_x: 5, position_y: 0)
  
    Queen.create(game_id: id, type: 'Queen', player: user_id, color: 'white', position_x: 4, position_y: 0)
    King.create(game_id: id, type: 'King',  player: user_id, color: 'white', position_x: 3, position_y: 0)
  
    # Populates black pieces in the database
    (0..7).each do |p|
      Pawn.create(game_id: id, type: 'Pawn', color: 'black', position_x: p, position_y: 6)
    end
  
    Rook.create(game_id: id, type: 'Rook', color:'black', position_x: 0, position_y: 7)
    Rook.create(game_id: id, type: 'Rook', color:'black', position_x: 7, position_y: 7)
  
    Knight.create(game_id: id, type: 'Knight', color: 'black', position_x: 1, position_y: 7)
    Knight.create(game_id: id, type: 'Knight', color: 'black', position_x: 6, position_y: 7)
  
    Bishop.create(game_id: id, type: 'Bishop', color: 'black', position_x: 2, position_y: 7)
    Bishop.create(game_id: id, type: 'Bishop', color: 'black', position_x: 5, position_y: 7)
      
    Queen.create(game_id: id, type: 'Queen', color: 'black', position_x: 4, position_y: 7)
    King.create(game_id: id, type: 'King', color: 'black', position_x: 3, position_y: 7)
  end
  
end




