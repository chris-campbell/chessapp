require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe "pieces#move action" do
    it "should update piece position" do
      user1 = FactoryBot.create(:user)
      game = FactoryBot.create(:game, user: user1, turn: 'black')
      piece = FactoryBot.create(:piece, color: 'white', type: 'Pawn', position_x: 0, position_y: 4, player: user1.id)
      sign_in user1
      
      put :move, params: { game_id: game.id, piece_id: piece.id, position_x: 0, position_y: 5, color: 'black' }
      piece.reload
      game.reload

      expect(piece.position_x).to eq 0
      expect(piece.position_y).to eq 5
    end
  end
end