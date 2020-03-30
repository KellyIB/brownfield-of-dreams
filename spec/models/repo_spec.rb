require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'instantiation' do
    it 'attributes' do
      attributes = {name: 'repo', html_url: 'link'}
      repo = Repo.new(attributes)

      expect(repo.name).to eq('repo')
      expect(repo.link).to eq('link')
    end
  end
end
