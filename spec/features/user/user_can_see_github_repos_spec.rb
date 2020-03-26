require 'rails_helper'

describe 'User' do
  describe 'with a github token:' do
    before(:each) do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      create(:user, github_token: ENV['GITHUB_TOKEN_2'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

    it 'can see links for 5 github repos', :vcr do
      within('#github') do
        within('#repos') do
          expect(page).to have_css('.github_link', count: 5)
          expect(page).to have_link('mod-0')
          expect(page).to have_link('backend_module_0_capstone')
          expect(page).to have_link('git_homework')
          expect(page).to have_link('best_animals')
          expect(page).to have_link('git_and_gh_practice')
        end
      end
    end

    it "can not see another user's github repos", :vcr do
      within('#github') do
        within('#repos') do
          expect(page).to_not have_link('hello-world')
          expect(page).to_not have_link('Mod0-S3-Practice')
        end
      end
    end
  end

  describe 'without a github token:' do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

    it 'can not see links for github repos', :vcr do
      expect(page).to_not have_css('#github')
    end
  end
end
