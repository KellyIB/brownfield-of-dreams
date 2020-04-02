require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  scenario "and it should destroy its videos" do
    admin = create(:admin)
    tutorial = create(:tutorial)
    tutorial2 = create(:tutorial)
    create_list(:video, 2, tutorial: tutorial)
    create_list(:video, 2, tutorial: tutorial2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    expect(Video.all.count).to eq(4)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(Video.all.count).to eq(2)

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end
end
