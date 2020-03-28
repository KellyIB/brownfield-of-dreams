require 'rails_helper'

describe 'User' do
  describe 'without a github token:' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      repo_json = File.read('spec/fixtures/github_repos.json')
      followers_json = File.read('spec/fixtures/github_followers.json')
      following_json = File.read('spec/fixtures/github_following.json')

      OmniAuth.config.mock_auth[:github] = nil
      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        {"provider" => "github",
        "info" => {"name" => "Test"},
        "credentials" =>
          {"token" => "123456",
            "expires" => false},
          "extra" =>
            {"raw_info" =>
              {"login" => "test-user",
                "html_url" => "htps://github.com/test-user",
                "name" => "Test User"}}})

      stub_request(:get, "https://api.github.com/user/repos?direction=asc&sort=created")
        .to_return(status: 200, body: repo_json)
      stub_request(:get, "https://api.github.com/user/followers")
        .to_return(status: 200, body: followers_json)
      stub_request(:get, "https://api.github.com/user/following")
        .to_return(status: 200, body: following_json)
    end

    it 'can connect to github' do
      expect(@user.github_token).to eq(nil)

      visit '/dashboard'
      click_link('Connect to GitHub')

      expect(current_path).to eq('/dashboard')

      expect(@user.github_token).to eq('123456')
    end
  end
end
