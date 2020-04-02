require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe 'instantiation' do
    it 'attributes' do
      attributes = { login: 'handle', html_url: 'link', id: '123' }
      follower = Follower.new(attributes)

      expect(follower.handle).to eq('handle')
      expect(follower.link).to eq('link')
      expect(follower.id).to eq('123')
    end
  end
end
