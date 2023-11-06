require 'rails_helper'

RSpec.feature 'User Edits a Project' do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:project) { create(:project, author: user) }

  before do
    sign_in(user)
  end

  scenario 'providing valid project attributes' do
    visit edit_project_path(project)
    fill_in('Project Name', with: 'Updated Example Name')
    click_on('Update Project')
    expect(page).to have_content('Project was successfully updated.')
    expect(page).to have_content('Updated Example Name')
  end

  scenario 'providing invalid project attributes' do
    visit edit_project_path(project)
    fill_in('Project Name', with: '')
    click_on('Update Project')
    expect(page).to have_selector '.alert', text: 'The form contains 1 error'
    page.find('#error_explanation').tap do |error_explanations|
      expect(error_explanations).to have_content("Name can't be blank")
    end
  end
end
