require 'rails_helper'

RSpec.describe 'User Views Projects', type: :feature do

  it 'succeeds when viewing the list' do
    project = create(:project)
    visit projects_path
    expect(page).to have_text 'LT-PBR Projects'
    expect(page).to have_text project.name
  end

  it 'succeeds when viewing a single project' do
    project = create(:project)
    visit project_path(project)
    expect(page).to have_text project.name
  end

end
