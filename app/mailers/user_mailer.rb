class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    subject = "Welcome to Government"
    mail(to: @user.email, subject: subject)
  end
end
