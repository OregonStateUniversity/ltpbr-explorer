require 'rails_helper'

RSpec.describe 'Admin Deletes a Project', type: :feature do

  it 'succeeds' do
    project = create(:project)
    admin = create(:user, :admin)
    log_in_as(admin)
    visit project_path(project)
    click_on 'Delete'
    expect(page).to_not have_text project.name
    expect(page).to have_text 'Project was successfully deleted'
  end

end
