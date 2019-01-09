FactoryBot.define do
  factory :invitation do
    game_id { 1 }
    player_id { 1 }
    guest_player_email { "MyString" }
  end
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end
  
  factory :game do
    name { "funkychess" }
    association :user
  end
  
  factory :empty_game, class: Game do
    name { "funkychess" }
    association :user
    after(:create) { |game| game.pieces.destroy_all }
  end
  
  factory :piece do
    type { 'Rook' }
    special { nil }
    color { 'white' }
    position_x { 0 }
    position_y { 0 }
    association :game
  end
  
  factory :king do
  end
  
  factory :knight do
  end
  
  factory :pawn do
  end

  factory :bishop do
  end

  factory :rook do
  end

  factory :queen do
  end
  
end