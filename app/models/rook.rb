class Rook < Piece

	def valid_move?(x, y)
		((position_x == x) || (position_y == y))
		super
	end
	
end
