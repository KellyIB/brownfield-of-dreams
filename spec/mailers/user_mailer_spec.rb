require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'methods' do
    it 'registration_confirmation' do
      user = create(:user)
      email = UserMailer.registration_confirmation(user).deliver_now
      expect(email.to).to eq([user.email])
      expect(email.from).to eq(['no_reply@example.com'])
      expect(email.subject).to eq('Register your Turing Tutorials account!')
      expect(email.body.encoded).to have_link('here', href: "http://test.example.com/users/#{user.id}/activate?token=#{user.confirmation_token}")
    end

    it 'registration_invitation' do
      user = create(:user)
      invitee = GithubUser.new(email: 'invite_me@example.com', name: 'Invitee')
      email = UserMailer.registration_invitation(user, invitee).deliver_now
      expect(email.to).to eq([invitee.email])
      expect(email.from).to eq(['no_reply@example.com'])
      expect(email.subject).to eq("#{user.first_name} has invited you to join Turing Tutorials!")
      expect(email.body.encoded).to have_link('here', href: 'http://test.example.com/register')
    end
  end
end
