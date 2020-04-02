require "rails_helper"

describe "/get_started" do
  it "can see a paragraph in the about", :vcr do
    visit "/get_started"

    expect(current_path).to eq("/get_started")
    expect(page).to have_content("Browse tutorials")
    expect(page).to have_link("homepage", count: 2)
    expect(page).to have_content("Filter results")
    expect(page).to have_content("Register to bookmark")
    expect(page).to have_link("Sign in")

  end
end
