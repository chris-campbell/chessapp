module ApplicationHelper
  def find_user(id)
    user = User.where(id: id)
    user[0].avatar
  end
end
