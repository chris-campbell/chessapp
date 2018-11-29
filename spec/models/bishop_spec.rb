require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe 'valid_move?' do
    it "should return true if move is valid" do
      game = FactoryBot.create(:game)
      bishop = FactoryBot.create(:bishop, position_x: 3, position_y: 3, game: game)

      expect(bishop.valid_move?(6, 6)).to eq(true)
    end
    
    it 'should return false if move is invalid' do
      game = FactoryBot.create(:game)
      bishop = FactoryBot.create(:bishop, position_x: 3, position_y: 3, game: game)

      expect(bishop.valid_move?(6, 5)).to eq(false)
    end
  end		
end
