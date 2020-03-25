require 'rails_helper'

describe 'User' do
  it 'user can sign in', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
  end
end
