require 'rails_helper'

RSpec.describe 'User edits profile', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  context 'with valid credentials' do
    it 'saves user with updated username' do
      fill_in('Username', with: 'new_username')
      fill_in('Current password', with: user.password)
      click_button('Update')
      expect(page).to have_selector '.alert', text: 'Your account has been updated successfully.'
      expect(page).to have_selector '.nav-link', text: 'new_username'
    end

    it 'saves user with updated affiliation' do
      fill_in('Affiliation', with: 'new_affiliation')
      fill_in('Current password', with: user.password)
      click_button('Update')
      expect(page).to have_selector '.alert', text: 'Your account has been updated successfully.'
      visit edit_user_registration_path
      expect(page).to have_field('Affiliation', with: 'new_affiliation')
    end
  end

  context 'with invalid credentials' do
    it 'fails and prompts for valid password' do
      fill_in('Username', with: 'new_username')
      fill_in('Current password', with: 'invalid_password')
      click_button('Update')
      expect(page).to have_selector '.alert', text: 'Current password is invalid'
    end
  end

  context 'with blank password' do
    it 'fails and prompts for a password' do
      fill_in('Username', with: 'new_username')
      click_button('Update')
      expect(page).to have_selector '.alert', text: 'Current password can\'t be blank'
    end
  end
end
