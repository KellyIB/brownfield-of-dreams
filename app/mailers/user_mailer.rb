class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: "Register your Turing Tutorials account!")
  end

  def registration_invitation(sender, invitee)
    @sender = sender
    @invitee = invitee
    mail(to: invitee.email, subject: "#{sender.first_name} has invited you to join Turing Tutorials!")
  end
end
