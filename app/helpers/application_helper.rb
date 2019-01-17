module ApplicationHelper
  
  def find_user(id)
    user = User.where(id: id)
    user[0].avatar
  end
  
  def current_user_white?(game)
    current_user.id == game.white_id
  end
  
  def format_time(time)
    "Last updated: #{time.strftime("%d-%m-%Y")}"
  end
  
end
