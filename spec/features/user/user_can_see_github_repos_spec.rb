require 'rails_helper'

describe 'As a user' do
  describe 'from the dashboard' do
    it 'I can see links for 5 of my github repos', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github') do
        expect(page).to have_link('Repo Name 1')
        expect(page).to have_link('Repo Name 2')
        expect(page).to have_link('Repo Name 3')
        expect(page).to have_link('Repo Name 4')
        expect(page).to have_link('Repo Name 5')
      end
    end
  end
end
