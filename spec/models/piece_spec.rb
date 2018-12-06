require 'rails_helper'

RSpec.describe Piece, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game, user: user) }

  describe '#obstructed?' do
    describe '#horizontal_obstruct' do

      before do
        game.pieces.map do |piece|
          piece.destroy!
        end
      end

      describe 'horizontal right' do
        let(:piece) { FactoryBot.create(:piece, position_x: 0, position_y: 0, game: game) } 
          
        it 'returns true if horizontal right is obstructed' do

          obstruction = FactoryBot.create(:piece, position_x: 2, position_y: 0, game: game)

          expect(piece.horizontal_obstruct?(5)).to eq true
        end

        it 'returns false if horizontal right isnt obstructed' do
          expect(piece.horizontal_obstruct?(5)).to eq false
        end
      end

      describe 'horizontal left' do
        let(:piece) { FactoryBot.create(:piece, position_x: 5, position_y: 0, game: game) }

        it 'returns true if horizontal left is obstructed' do
          obstruction = FactoryBot.create(:piece, position_x: 2, position_y: 0, game: game)

          expect(piece.horizontal_obstruct?(0)).to eq true
        end

        it 'returns false if horizontal left isnt obstructed' do
          expect(piece.horizontal_obstruct?(0)).to eq false
        end
      end
    end

    describe '#diagonal_obstruct?' do

      before do 
        game.pieces.map do |piece|
          piece.destroy!
        end
      end

      describe 'diagonal up' do
        let(:piece) { FactoryBot.create(:piece, position_x: 0, position_y: 0, game: game) }

        it 'returns true if diagonal up is obstructed' do
          obstruction = FactoryBot.create(:piece, position_x: 2, position_y: 2, game: game)

          expect(piece.diagonal_obstruct?(4, 4)).to eq true
        end

        it 'returns false if diagonal up isnt obstructed' do
          expect(piece.diagonal_obstruct?(4, 4)).to eq false
        end
      end

      describe 'diagonal down' do
        let(:piece) { FactoryBot.create(:piece, position_x: 4, position_y: 4, game: game) }

        it 'returns true if diagonal down is obstructed' do
          obstruction = FactoryBot.create(:piece, position_x: 2, position_y: 2, game: game)

          expect(piece.diagonal_obstruct?(0, 0)).to eq true
        end

        it 'returns false if diagonal down isnt obstructed' do
          expect(piece.diagonal_obstruct?(0, 0)).to eq false
        end
      end
    end 

    describe '#vertical_obstruct?' do

      before do
        game.pieces.map do |piece|
          piece.destroy!
        end
      end

      describe 'vertical down' do
        let(:piece) { FactoryBot.create(:piece, position_x: 0, position_y: 1, game: game) }

        it 'returns true if obstructed' do
          obstruction = FactoryBot.create(:piece, position_x: 0, position_y: 3, game: game)

          expect(piece.vertical_obstruct?(5)).to eq true
        end

        it 'returns false if not obstructed' do
          expect(piece.vertical_obstruct?(5)).to eq false
        end
      end

      describe 'vertical up' do
        let(:piece) { FactoryBot.create(:piece, position_x: 0, position_y: 7, game: game) }

        it 'returns true when occupied' do
          obstruction = FactoryBot.create(:piece, position_x: 0, position_y: 5, game: game)

          expect(piece.vertical_obstruct?(3)).to eq true
        end

         it 'returns false when not occupied' do
           expect(piece.vertical_obstruct?(0)).to eq false
         end
      end
    end
  end

  describe '#capture!' do

      before do
        game.pieces.map do |piece|
          piece.destroy!
        end
      end

      it "determine if piece is capturable?" do
        rook = FactoryBot.create(:rook, position_x: 0, position_y: 0, color: 'white', game: game)
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'black', game: game)

        expect(rook.capturable?(0, 3)).to eq true
      end

      it 'determines if piece is not capturable?' do
        rook = FactoryBot.create(:rook, position_x: 0, position_y: 0, color: 'white', game: game)
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'white', game: game)

        expect(rook.capturable?(0, 3)).to eq false
      end

      it "update captured piece values to reflect capture" do
        rook = FactoryBot.create(:rook, position_x: 0, position_y: 0, color: 'white', game: game)
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'black', game: game)

        rook.capture!(0, 3)

        piece.reload

        expect(rook.position_x).to eq 0
        expect(rook.position_y).to eq 3

        expect(piece.position_x).to eq 8
        expect(piece.position_y).to eq 8
        expect(piece.dead).to eq true 
      end

      it "return true if pieces are the same color" do
        piece1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, color: 'black', game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'black', game: game)

        expect(piece1.same_color?(0, 3)).to eq true
      end

      it "returns false is not same color" do
        piece1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, color: 'black', game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'white', game: game)

        expect(piece1.same_color?(0, 3)).to eq false
      end

      it "updates piece location" do
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 0, color: 'black', game: game)

        piece.move_to!(0, 3)
        piece.reload

        expect(piece.position_x).to eq 0
        expect(piece.position_y).to eq 3
      end

      it "returns true if a piece is present" do
        piece1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, color: 'black', game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'white', game: game)

        expect(piece1.piece_present_at?(0, 3)).to eq true
      end

      it "returns true if present piece is capturable?" do
        piece1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, color: 'black', game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'white', game: game)

        expect(piece1.capturable?(0, 3)).to eq true
      end

      it "returns false if present piece isnt capturable?" do
        piece1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, color: 'black', game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3, color: 'black', game: game)

        expect(piece1.capturable?(0, 3)).to eq false
      end
    end

    describe 'valid_move' do

      it "should return false if the piece has been moved off the board" do
        piece1 = FactoryBot.create(:piece)

        expect(piece1.valid_move?(-1, 0)).to eq false
        expect(piece1.valid_move?(0, 9)).to eq false
      end 
    end

    describe 'general functions' do
      it "Should return true if piece present at given location" do
        piece1 = FactoryBot.create(:piece, game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3)

        expect(piece2.piece_present_at?(0, 0)).to eq(true)
      end
    end

    describe 'general functions' do

      it "Should return true if piece present at given location" do
        piece1 = FactoryBot.create(:piece, game: game)
        piece2 = FactoryBot.create(:piece, position_x: 0, position_y: 3)

        expect(piece2.piece_present_at?(0, 5)).to eq(false)
      end

      it "should return true if piece is white?" do
        piece1 = FactoryBot.create(:piece, game: game)

        expect(piece1.white?).to eq true
      end

      it 'should return false if piece is not white?' do
        piece1 = FactoryBot.create(:piece, game: game, color: 'black')

        expect(piece1.white?).to eq false
      end

      it 'should return true if piece is black?' do
        piece1 = FactoryBot.create(:piece, game: game, color: 'black')

        expect(piece1.black?).to eq true
      end

      it 'should return false if piece is not black?' do
        piece1 = FactoryBot.create(:piece)

        expect(piece1.black?).to eq false
      end

      it 'should return true if piece in same position' do
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 0)

        expect(piece.same_position?(0, 0)).to eq true
      end

      it 'should return false if in different position' do
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 0)

        expect(piece.same_position?(0, 3)).to eq false
      end

      it 'should update captured piece to represent capture' do
        game = FactoryBot.create(:game)
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)
        capturable_piece = FactoryBot.create(:piece, color: 'black', position_x: 0, position_y: 1, game_id: game.id)

        piece.update_captured_piece!(0, 1)
        capturable_piece.reload

        expect(capturable_piece.dead).to eq true
        expect(capturable_piece.position_x).to eq 8
        expect(capturable_piece.position_y).to eq 8
      end

      it 'should update piece location in the database' do
        game = FactoryBot.create(:game)
        piece = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)

        piece.move_to!(0, 1)

        piece.reload
        expect(piece.position_x).to eq 0
        expect(piece.position_y).to eq 1
      end
    end
end