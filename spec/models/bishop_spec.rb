require 'rails_helper'

RSpec.describe Bishop, type: :model do
		describe 'valid' do
			it "should move diagonally 3 spaces" do
				user = FactoryBot.create(:user)
				game = FactoryBot.create(:game, user: user)
				bishop = FactoryBot.create(:bishop, position_x: 2, position_y: 0, game: game)

				expect(bishop.valid_move(5, 3)).to eq(true)
			end
		end		
end
