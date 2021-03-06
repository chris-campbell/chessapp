class User < ApplicationRecord
  # before_save { self.email = email.downcase! }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :games, :dependent => :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                       format:     { with: VALID_EMAIL_REGEX }
 
  mount_uploader :avatar, AvatarUploader

  # Sent when new user is created in system.
  # after_create :send_email
  # def send_email
  #   NotificationMailer.comment_added(self).deliver
  # end

  def invitation
    InvitationMailer.send_invitation(self).deliver
  end
end
