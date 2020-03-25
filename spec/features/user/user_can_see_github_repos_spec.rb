require 'rails_helper'

describe 'As a user' do
  describe 'from the dashboard' do
    it 'I can see links for 5 of my github repos', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github') do
        expect(page).to have_css('.github_link', count: 5)
        expect(page).to have_link('mod-0')
        expect(page).to have_link('backend_module_0_capstone')
        expect(page).to have_link('git_homework')
        expect(page).to have_link('best_animals')
        expect(page).to have_link('git_and_gh_practice')
      end
    end
  end
end
