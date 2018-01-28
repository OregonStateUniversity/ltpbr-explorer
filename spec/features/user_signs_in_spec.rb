require 'rails_helper'

RSpec.describe 'User signs in', type: :feature do

  def sign_in_as(user)
    fill_in('Username', with: user.username)
    fill_in('Password', with: user.password)
    click_button('Sign In')
  end

  before do
    visit new_user_session_path
  end

  let(:user) { create(:user) }

  context 'with valid credentials' do
    it 'sees a success message' do
      sign_in_as(user)
      expect(page).to have_selector '.notice', text: 'Signed in successfully.'
    end
  end

end