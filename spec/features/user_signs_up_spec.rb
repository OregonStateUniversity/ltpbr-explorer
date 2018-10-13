require 'rails_helper'

RSpec.describe 'User signs up', type: :feature do

  before { visit new_user_registration_path }

  context 'with valid signup information' do
    it 'sees a success message' do
      fill_in('Username', with: 'valid_username')
      fill_in('Email', with: 'valid@email.com')
      fill_in('Name', with: 'Fake Name')
      fill_in('Affiliation', with: 'Fake Affiliation')
      fill_in('Password', with: 'valid_password')
      fill_in('Password confirmation', with: 'valid_password')
      click_on('Sign up')
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  context 'with invalid signup information' do
    it 'sees a error message' do
      fill_in('Username', with: '')
      fill_in('Email', with: 'invalid@email')
      fill_in('Password', with: 'a')
      fill_in('Password confirmation', with: 'z')
      click_on('Sign up')
      expect(page).to have_selector '.alert-error'
    end
  end
end
