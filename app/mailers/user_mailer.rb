class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: "Register your Turing Tutorials account!")
  end
end
