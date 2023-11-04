require 'rails_helper'

RSpec.describe 'Admin Updates a Project Cover Photo', type: :feature do

  it 'succeeds' do
    project = create(:project)
    admin = create(:user, :admin)
    log_in_as(admin)
    visit edit_project_cover_photo_path(project, project)
    attach_file('project_cover_photo', 'spec/support/stream_cover.jpg')
    click_on 'Upload'
    expect(page).to have_text project.name
    expect(page).to have_text 'Project cover photo has been updated'
    expect(page).to have_css("img[src*='stream_cover.jpg']")
  end

  it 'redisplays when the form is submitted without a new photo' do
    project = create(:project)
    admin = create(:user, :admin)
    log_in_as(admin)
    visit edit_project_cover_photo_path(project, project)
    click_on 'Upload'
    expect(page).to have_text 'Change Project Cover Photo'
    expect(page).to have_text 'Please select a new cover photo to upload'
  end

end
