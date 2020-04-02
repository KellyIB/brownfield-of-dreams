require 'rails_helper'

describe YoutubeService do
  describe 'methods' do
    it 'video_info', :vcr do
      service = YoutubeService.new
      info = service.video_info('qMkRHW9zE1c')
      expect(info[:items].first[:snippet][:title]).to eq("Prework - Environment Setup")
    end
  end
end
