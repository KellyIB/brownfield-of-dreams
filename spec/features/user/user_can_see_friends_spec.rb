require 'rails_helper'

describe 'User' do
  describe 'with a github token:' do
    before(:each) do
      user = create(:user, github_token: '123456')
      create(:user, github_token: '109824', github_id: '10391857')

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

    it 'can see see a link to add friends only for registered users' do
      within('#github') do
        within('#followers') do
          within('#follower-iEv0lv3') do
            expect(page).to have_link('Add as Friend')
          end
          within('#follower-rcallen89') do
            expect(page).to_not have_link('Add as Friend')
          end
        end
      end
    end

    it 'can add a follower to friends' do
      expect(page).to_not have_css('#friends')

      within('#follower-iEv0lv3') { click_link('Add as Friend') }

      expect(current_path).to eq('/dashboard')

      within('#follower-iEv0lv3') { expect(page).to_not have_link('Add as Friend') }

      within('#friends') { expect(page).to have_css('.friend', count: 1) }
    end

    it 'gets an error when adding invalid friend' do
      expect(page).to_not have_css('#friends')

      User.last.destroy
      within('#follower-iEv0lv3') { click_link('Add as Friend') }

      expect(current_path).to eq('/dashboard')

      expect(page).to_not have_css('#friends')
      expect(page).to have_content('Friend must exist')
    end
  end
end
