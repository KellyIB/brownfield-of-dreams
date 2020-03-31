require 'rails_helper'

describe 'Registered user' do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    expect(page).to have_content("Status: inactive - This account has not yet been activated. Please check your email.")
  end

  it 'can confirm registration via a link sent by email' do
    visit user_activate_path(@user, token: @user.confirmation_token)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Thank you! Your account is now activated.")

    @user.reload
    visit dashboard_path

    expect(page).to have_content("Status: active")
    expect(page).to_not have_content("Status: inactive - This account has not yet been activated. Please check your email.")
  end

  it 'gets feedback if token is invalid' do
    visit user_activate_path(@user, token: '12345678')

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Something went wrong.")
  end
end
