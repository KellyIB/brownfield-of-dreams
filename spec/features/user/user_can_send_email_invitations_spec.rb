require 'rails_helper'

describe 'Registered user' do
  before(:each) do
    user = create(:user, github_token: '123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    repo_json = File.read('spec/fixtures/github_repos.json')
    followers_json = File.read('spec/fixtures/github_followers.json')
    following_json = File.read('spec/fixtures/github_following.json')
    user_json = File.read('spec/fixtures/github_user.json')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    requests = ['repos?direction=asc&sort=created', 'followers', 'following']
    responses = [repo_json, followers_json, following_json]

    requests.zip(responses).each do |request, response_body|
      stub_request(:get, "https://api.github.com/user/#{request}")\
        .with(headers: {"Authorization" => "token #{user.github_token}"})
        .to_return(status: 200, body: response_body)
    end

    stub_request(:get, "https://api.github.com/users/test-user")\
      .with(headers: {"Authorization" => "token #{user.github_token}"})
      .to_return(status: 200, body: user_json)

    visit dashboard_path
  end

  it "can send email invitations" do
    click_link "Send an Invite"

    expect(current_path).to eq('/invite')

    fill_in 'github_handle', with: 'test-user'
    click_button('Send Invite')

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Successfully sent invite!")
  end

end
