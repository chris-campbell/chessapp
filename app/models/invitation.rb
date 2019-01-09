class Invitation < ActiveRecord::Base
  after_create :send_invitation_email

  belongs_to :game
  belongs_to :user

  def send_invitation_email
    InvitationMailer.send_invitation(self).deliver
  end
end