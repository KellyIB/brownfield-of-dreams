require 'rails_helper'

describe 'Visitor' do
  it "can't bookmark a video and sees the button is replaced" do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to_not have_button('Bookmark')
    expect(page).to have_content('Bookmark')
  end
end
