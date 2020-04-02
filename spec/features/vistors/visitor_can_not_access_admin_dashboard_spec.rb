require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    visit '/admin/dashboard'

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
