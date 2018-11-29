require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe 'valid' do
    it "should return true if move vaild" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:empty_game, user: user)
      rook = FactoryBot.create(:rook, position_x: 0, position_y: 0, game: game)

      expect(rook.valid_move?(0, 4)).to eq true
    end
    
    it "should return false if rook move is invalid" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:empty_game, user: user)
      rook = FactoryBot.create(:rook, position_x: 0, position_y: 0, game: game)

      expect(rook.valid_move?(1, 4)).to eq false
    end
  end
end
