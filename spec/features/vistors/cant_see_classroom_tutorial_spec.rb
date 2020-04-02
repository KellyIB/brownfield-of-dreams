require 'rails_helper'

describe 'visitors view' do
  it 'vistor cannot see classroom tutorials title' do
    tutorial1 = create(:tutorial, classroom: true)
    tutorial2 = create(:tutorial, classroom: false)

    visit '/'

    expect(page).to_not have_content(tutorial1.title)
    expect(page).to have_content(tutorial2.title)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial2.title)
  end
end
