require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  describe 'instantiation' do
    it 'attributes' do
      attributes = {name: 'Keagan', email: 'keagan@example.com'}
      user = GithubUser.new(attributes)

      expect(user.name).to eq('Keagan')
      expect(user.email).to eq('keagan@example.com')
    end
  end
end
