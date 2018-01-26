require 'rails_helper'

RSpec.describe 'User edits profile', :type => :feature do

  def sign_in_as(user)
    visit new_user_session_path
    fill_in('Username', with: user.username)
    fill_in('Affiliation', with: user.affiliation)
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
      user.reload
      expect(user.username).to match('new_username')
    end

end
