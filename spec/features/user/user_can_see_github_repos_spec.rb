require 'rails_helper'

describe 'User' do
  describe 'with a github token:' do
    before(:each) do
      user = create(:user, github_token: '123456')
      create(:user, github_token: '109824')

      repo_json = File.read('spec/fixtures/github_repos.json')
      followers_json = File.read('spec/fixtures/github_followers.json')
      following_json = File.read('spec/fixtures/github_following.json')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      stub_request(:get, "https://api.github.com/user/repos?direction=asc&sort=created")
        .to_return(status: 200, body: repo_json)
      stub_request(:get, "https://api.github.com/user/followers")
        .to_return(status: 200, body: followers_json)
      stub_request(:get, "https://api.github.com/user/following")
        .to_return(status: 200, body: following_json)

      visit '/dashboard'
    end

    it 'can see links for 5 github repos' do

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

    # it "can not see another user's github repos" do
    #   within('#github') do
    #     within('#repos') do
    #       expect(page).to_not have_link('hello-world')
    #       expect(page).to_not have_link('Mod0-S3-Practice')
    #     end
    #   end
    # end
  end

  describe 'without a github token:' do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

    it 'can not see links for github repos' do
      expect(page).to_not have_css('#github')
    end
  end
end
