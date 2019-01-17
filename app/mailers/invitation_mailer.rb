class InvitationMailer < ApplicationMailer
    default from: 'no-reply@chessmate.com'
    def send_invitation(user_info)
        @email = user_info[:email]
        @name = user_info[:name]
        @game = user_info[:game_id]
        @user = user_info[:user]
        @url = "https://chess-main-kris-camp.c9users.io/games/" + "#{@game}/invite"

        mail(to: @email, subject: "You're getting challenged from a #{@user.email} on Chessmate!")
    end
    
end
