require 'rails_helper'

RSpec.feature 'User creates bda project' do
  include Devise::Test::IntegrationHelpers

  context 'when logged in' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    scenario 'providing valid project attributes' do
      visit new_project_path
      fill_in('Affiliation', with: 'Example Affiliation')
      fill_in('Stream name', with: 'Example Stream Name')
      fill_in('Implementation date', with: Date.today)
      fill_in('Narrative', with: 'Example Project Narrative')
      fill_in('Area', with: 1000)
      check('Maintenance?')
      fill_in('Contact Name', with: 'Example Contact Name')
      click_on('Create project')
      expect(page).to have_content('Project was successfully created.')
    end
  end
end
