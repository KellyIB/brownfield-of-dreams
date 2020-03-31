require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2 = create(:tutorial, title: "How to Learn Karate")
    video6 = create(:video, title: "Sweep the Leg", tutorial: tutorial2, position: 3)
    video2 = create(:video, title: "The Bunny Round the Bush Technique", tutorial: tutorial1, position: 2)
    video3 = create(:video, title: "Sand the Floor Technique", tutorial: tutorial2, position: 3)
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1, position: 1)
    video5 = create(:video, title: "Wax On, Wax Off Technique", tutorial: tutorial2, position: 2)
    video4 = create(:video, title: "Paint the Fence Technique", tutorial: tutorial2, position: 1)
    video7 = create(:video, title: "The Crane", tutorial: tutorial2, position: 4)
    user = create(:user)
    create(:user_video, video_id: video2.id, user_id: user.id)
    create(:user_video, video_id: video5.id, user_id: user.id)
    create(:user_video, video_id: video4.id, user_id: user.id)
    create(:user_video, video_id: video3.id, user_id: user.id)
    create(:user_video, video_id: video1.id, user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    within('#bookmarks') do
      expect(page).to have_link("#{tutorial1.title}", count: 2)
      expect(page).to have_link("#{tutorial2.title}", count: 3)
      within('#video-1') { expect(page).to have_link("#{video1.title}") }
      within('#video-2') { expect(page).to have_link("#{video2.title}") }
      within('#video-3') { expect(page).to have_link("#{video4.title}") }
      within('#video-4') { expect(page).to have_link("#{video5.title}") }
      within('#video-5') { expect(page).to have_link("#{video3.title}") }
      expect(page).to_not have_link("#{video6.title}")
      expect(page).to_not have_link("#{video7.title}")
    end
  end
end
