require 'rails_helper'

RSpec.describe 'user signs in', :type => :feature do

  def sign_in_as(user)
    visit new_user_session_path
    fill_in('Username', with: user.username)
    fill_in('Password', with: user.password)
    click_button('Sign In')
  end

  let(:user) { create(:user) }

  it 'allows a valid user to sign in' do
    sign_in_as(user)
    expect(page).to have_selector '.alert', text: 'Signed in successfully.'
  end
end
