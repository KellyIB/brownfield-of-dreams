require 'rails_helper'

describe 'User' do
  describe 'with a github token:' do
    before(:each) do
      user = create(:user, github_token: '123456')
      user2 = create(:user, github_token: '109824')

      repo_json = File.read('spec/fixtures/github_repos.json')
      repo_json_2 = File.read('spec/fixtures/github_repos_2.json')
      followers_json = File.read('spec/fixtures/github_followers.json')
      following_json = File.read('spec/fixtures/github_following.json')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      requests = ['repos?direction=asc&sort=created', 'followers', 'following']
      responses = [repo_json, followers_json, following_json]
      responses_2 = [repo_json_2, followers_json, following_json]

      requests.zip(responses).each do |request, response_body|
        stub_request(:get, "https://api.github.com/user/#{request}")\
          .with(headers: {"Authorization" => "token #{user.github_token}"})
          .to_return(status: 200, body: response_body)
      end

      requests.zip(responses_2).each do |request, response_body|
        stub_request(:get, "https://api.github.com/user/#{request}")\
          .with(headers: {"Authorization" => "token #{user2.github_token}"})
          .to_return(status: 200, body: response_body)
      end

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
          expect(page).to_not have_link('not_my_repo')
          expect(page).to_not have_link('other-users-repo')
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

    it 'can not see links for github repos' do
      expect(page).to_not have_css('#github')
    end
  end
end
