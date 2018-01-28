require 'rails_helper'

RSpec.describe 'User signs in' do

  def sign_in_as(user)
    byebug
    visit new_user_session_path
    fill_in('Username', with: user.username)
    fill_in('Password', with: user.password)
    click_button('Sign In')
    byebug
  end

  let(:user) { create(:user) }

  context 'with valid credentials' do
    it 'sees a success message' do
      byebug
      sign_in_as(user)
      byebug
      expect(page).to have_selector '.notice', text: 'Signed in successfully.'
    end
  end

end
