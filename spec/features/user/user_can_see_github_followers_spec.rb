require 'rails_helper'

describe 'User' do
  describe 'with a github token:' do
    before(:each) do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      create(:user, github_token: ENV['GITHUB_TOKEN_2'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

    it 'can see all github followers', :vcr do
      within('#github') do
        within('#followers') do
          expect(page).to have_css('.github_link', count: 2)
          expect(page).to have_link('rcallen89')
          expect(page).to have_link('iEv0lv3')
        end
      end
    end
  end
end
