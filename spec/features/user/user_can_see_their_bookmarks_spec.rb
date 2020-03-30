require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2= create(:tutorial, title: "How to Learn Karate")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
    video2 = create(:video, title: "The Bunny Round the Bush Technique", tutorial: tutorial1)
    video3 = create(:video, title: "Sand the Floor Technique", tutorial: tutorial2)
    video4 = create(:video, title: "Paint the Fence Technique", tutorial: tutorial2)
    video5 = create(:video, title: "Wax On, Wax Off Technique", tutorial: tutorial2)
    video6 = create(:video, title: "Sweep the Leg", tutorial: tutorial2)
    video7 = create(:video, title: "The Crane", tutorial: tutorial2)
    user = create(:user)
    user_video1 = create(:user_video, video_id: video1.id, user_id: user.id)
    user_video2 = create(:user_video, video_id: video2.id, user_id: user.id)
    user_video3 = create(:user_video, video_id: video3.id, user_id: user.id)
    user_video4 = create(:user_video, video_id: video4.id, user_id: user.id)
    user_video5 = create(:user_video, video_id: video5.id, user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    within('#bookmarks') do
      within("#tutorial-#{tutorial1.id}") do
        expect(page).to have_content("#{video1.title}")
        expect(page).to have_content("#{video2.title}")
      end
    end
save_and_open_page
    within('#bookmarks') do
      within("#tutorial-#{tutorial2.id}") do
        expect(page).to have_content("#{video3.title}")
        expect(page).to have_content("#{video4.title}")
        expect(page).to have_content("#{video5.title}")
        expect(page).to_not have_content("#{video6.title}")
        expect(page).to_not have_content("#{video7.title}")
      end
    end
  end
end
