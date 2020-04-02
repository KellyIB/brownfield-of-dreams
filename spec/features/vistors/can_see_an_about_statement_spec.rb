require "rails_helper"

describe "/about" do
  it "can see a paragraph in the about", :vcr do
    visit "/about"

    expect(current_path).to eq("/about")
    expect(page).to have_content("It's designed for anyone learning how to code")
  end
end
