require 'rails_helper'

RSpec.describe 'User signs in', type: :feature do

  before { visit new_user_session_path }

  context 'with valid credentials' do
    let(:user) { create(:user) }

    it 'sees a success message' do
      fill_in('Username', with: user.username)
      fill_in('Password', with: user.password)
      click_button('Sign In')
      expect(page).to have_selector '.alert', text: 'Signed in successfully.'
    end
  end

  context 'with invalid credentials' do
    it 'sees a failure message' do
      fill_in('Username', with: 'FAKE')
      fill_in('Password', with: 'FAKE')
      click_button('Sign In')
      expect(page).to have_selector '.alert', text: 'Invalid Login or password.'
    end
  end

end
