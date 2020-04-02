require 'rails_helper'

RSpec.describe YouTube::Video do
  it 'can get a thumbnail by video_id', :vcr do
    video = YouTube::Video.by_id("J7ikFUlkP_k")
    expect(video.thumbnail).to eq("https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg")
  end
end
