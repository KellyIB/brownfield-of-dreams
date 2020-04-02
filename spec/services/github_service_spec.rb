require 'rails_helper'

describe GithubService do
  describe 'methods' do
    before(:each) do
      @user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @service = GithubService.new
    end

    it 'get_repo_data', :vcr do
      repo_data = @service.get_repo_data(@user)
      expect(repo_data.first.keys.include?(:name)).to eq(true)
      expect(repo_data.first.keys.include?(:html_url)).to eq(true)
    end

    it 'get_follower_data', :vcr do
      follower_data = @service.get_follower_data(@user)
      expect(follower_data.first.keys.include?(:login)).to eq(true)
      expect(follower_data.first.keys.include?(:html_url)).to eq(true)
      expect(follower_data.first.keys.include?(:id)).to eq(true)
    end

    it 'get_following_data', :vcr do
      following_data = @service.get_following_data(@user)
      expect(following_data.first.keys.include?(:login)).to eq(true)
      expect(following_data.first.keys.include?(:html_url)).to eq(true)
      expect(following_data.first.keys.include?(:id)).to eq(true)
    end

    it 'get_user_data', :vcr do
      user_data = @service.get_user_data(@user, 'octocat')
      expect(user_data.keys.include?(:email)).to eq(true)
      expect(user_data.keys.include?(:name)).to eq(true)
    end
  end
end
