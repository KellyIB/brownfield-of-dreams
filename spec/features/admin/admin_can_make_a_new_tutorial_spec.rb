require 'rails_helper'

describe "Admin " do
  it "can create a new tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    click_link('Create New Tutorial')

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in "Title", with: "How to create a new tutorial"
    fill_in "Description", with: "You too can create a new tutorial."
    fill_in "Thumbnail", with: "http://i3.ytimg.com/vi/BDliEq_0qeQ/hqdefault.jpg"

    click_button("Save")

    tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    expect(page).to have_content("Successfully created tutorial.")

  end

  it "cannot create a new tutorial with incomplete information" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    click_link('Create New Tutorial')

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in "Title", with: "How to create a new tutorial"
    fill_in "Description", with: "You too can create a new tutorial."
    fill_in "Thumbnail", with: ""

    click_button("Save")

    expect(page).to have_content("Thumbnail can't be blank")
  end
end
