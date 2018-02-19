require 'rails_helper'

RSpec.feature 'User creates bda project' do
  include Devise::Test::IntegrationHelpers

  context 'when logged in' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit new_project_path
    end

    scenario 'providing valid project attributes' do
      fill_in('Affiliation', with: 'Example Affiliation')
      fill_in('Stream name', with: 'Example Stream Name')
      fill_in('Implementation date', with: Date.today)
      fill_in('Latitude', with: 45.0000)
      fill_in('Longitude', with: 45.0000)
      fill_in('Narrative', with: 'Example Project Narrative')
      fill_in('Area', with: 1000)
      check('Maintenance?')
      fill_in('Primary contact', with: 'Example Contact Name')
      click_on('Create Project')
      expect(page).to have_content('Project was successfully created.')
    end

    scenario 'providing invalid project attributes' do
      click_on('Create Project')
      expect(page).to have_selector '.alert', text: 'The form contains 9 errors.'
      page.find('#error_explanation').tap do |error_explanations|
        expect(error_explanations).to have_content("Affiliation can't be blank")
        expect(error_explanations).to have_content("Stream name can't be blank")
        expect(error_explanations).to have_content("Implementation date can't be blank")
        expect(error_explanations).to have_content("Latitude can't be blank")
        expect(error_explanations).to have_content('Latitude is not a number')
        expect(error_explanations).to have_content("Longitude can't be blank")
        expect(error_explanations).to have_content('Longitude is not a number')
        expect(error_explanations).to have_content("Area is not a number")
        expect(error_explanations).to have_content("Primary contact can't be blank")
      end
    end
  end
end
