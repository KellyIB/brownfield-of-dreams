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
      stub_request(:get, 'https://api.github.com/user/repos?direction=asc&sort=created')
        .to_return(status: 200, body: repo_json)
      stub_request(:get, 'https://api.github.com/user/followers')
        .to_return(status: 200, body: followers_json)
      stub_request(:get, 'https://api.github.com/user/following')
        .to_return(status: 200, body: following_json)

      visit '/dashboard'
    end

    it 'can see all github followers' do
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
