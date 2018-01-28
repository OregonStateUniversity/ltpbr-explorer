require 'rails_helper'

RSpec.describe 'User edits profile' do

  before do
    driven_by :rack_test
  end

  def sign_in_as(user)
    visit new_user_session_path
    fill_in('Username', with: user.username)
    fill_in('Password', with: user.password)
    click_button('Sign In')
  end

  let(:user) { create(:user) }

  context 'with valid credentials' do
    it 'saves user with updated username' do
      sign_in_as(user)
      visit edit_user_registration_path
      fill_in('Username', with: 'new_username')
      fill_in('Current password', with: user.password)
      click_button('Update')
      expect(page).to have_selector '.notice', text: 'Your account has been updated successfully.'
      expect(page).to have_selector '.nav-link', text: 'new_username'
    end

    it 'saves user with updated affiliation' do
      sign_in_as(user)
      visit edit_user_registration_path
      fill_in('Affiliation', with: 'new_affiliation')
      fill_in('Current password', with: user.password)
      click_button('Update')
      expect(page).to have_selector '.notice', text: 'Your account has been updated successfully.'
      visit edit_user_registration_path
      expect(page).to have_field('Affiliation', with: 'new_affiliation')
    end
  end

end
