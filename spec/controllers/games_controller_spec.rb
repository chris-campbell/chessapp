require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    describe "games#index action" do
      
        it "should successfully allow user to access new form" do
          user = FactoryBot.create(:user)
          sign_in user
          get :new
            
          expect(response).to have_http_status(:success)
        end
        
        it 'should redirect user to signin page if not logged in' do
          get :new
            
          expect(response).to redirect_to new_user_session_path
        end
        
        it "should redirect to game show if game create successful" do
          user = FactoryBot.create(:user)

          sign_in user
          
          post :create, params: {
            game: { 
              name: 'grandmaster', 
              user: user 
            }
          }
          game = Game.last
          expect(response).to redirect_to(game_path(game))
        end
        
    
    end
    
  describe '#join' do
  
    it 'should render show after player joins game as black' do
      user1 = FactoryBot.create(:user)
      sign_in user1
      game = FactoryBot.create(:game, white_id: user1.id)
      user2 = FactoryBot.create(:user, email: 'example@domain.com')

      get :join, params: { game_id: game.id }
      
      if game
    	  current_pieces = game.friendly_pieces('black')
    	  current_pieces.each do |piece|
    	    if game.black_id.nil?
    	      piece.update_attributes(player: user2.id)
    	    end
    	  end
	    end
      
      game.black_id = user2.id
           
      expect(game.black_id.to_i).to eq user2.id
      expect(response).to render_template(:show)
    end
  end
    
end
