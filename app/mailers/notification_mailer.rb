class NotificationMailer < ApplicationMailer
    default from: "no-reply@chessmateapp.com"
    
    
    def comment_added(user)
        mail(to: user.email,
            subject: "You have successfully signed up to Chessmate!")
    end
end
