require 'rails_helper'

describe 'Visitor', type: :feature do
  it 'has an unactivated account upon registration' do
    email = 'wolfingtonbrothers@earthlink.net'
    first_name = 'Lionel'
    last_name = 'Prichert'
    password = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as Lionel Prichert.")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
end
