require 'rails_helper'

RSpec.describe "User's GitHub Repo", :vcr do
  it "can see the user's github repos" do
    user = create(:user, github_token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within("#github") do
      expect(page).to have_link("mod-0")
      expect(page).to have_link("backend_module_0_capstone")
      expect(page).to have_link("git_homework")
      expect(page).to have_link("best_animals")
      expect(page).to have_link("git_and_gh_practice")
    end
  end
end
