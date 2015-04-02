class UserMailer < ApplicationMailer
  default from: 'Organizations-ck <welocme@organizations-ck.herokuapp.com>'

  def welcome_email(user)
    @user = user
    subject = "Welcome to Organizations-ck"
    mail(to: @user.email, subject: subject)
    headers['X-MC-InlineCSS'] = true
  end
end
