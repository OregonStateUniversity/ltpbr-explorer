require 'rails_helper'

RSpec.describe 'user logs in' do

  def log_in_as(user)
    visit new_user_session_path
    fill_in('Username', with: user.username)
    fill_in('Password', with: user.password)
    click_button('Log in')
  end

  let(:user) { create(:user) }

  it 'allows a valid user to log in' do
    log_in_as(user)
    expect(page).to have_selector '.alert', text: 'Signed in successfully.'
  end
end
