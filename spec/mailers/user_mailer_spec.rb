require "rails_helper"

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
  end
end
