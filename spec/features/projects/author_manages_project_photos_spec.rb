require 'rails_helper'

RSpec.describe 'Admin Manages Project Photos', type: :feature do

  describe 'adding a photo' do
    it 'succeeds' do
      author = create(:user)
      project = create(:project, author: author)
      log_in_as(author)
      visit project_path(project)
      within '#add_project_photo' do
        attach_file('project_photo_image', 'spec/support/stream01.jpg')
        fill_in 'Date of Photo', with: '01/01/2020'
        fill_in 'Description', with: 'Fake description'
        click_on 'Upload'
      end
      expect(page).to have_text project.name
      expect(page).to have_text 'Photo has been added'
      expect(page).to have_css("img[src*='stream01.jpg']")
    end

    it 'redisplays when the form is submitted without a new photo' do
      author = create(:user)
      project = create(:project, author: author)
      log_in_as(author)
      visit project_path(project)
      within '#add_project_photo' do
        click_on 'Upload'
      end
      expect(page).to have_text project.name
      expect(page).to have_text 'Could not add the photo'
    end
  end

  describe 'editing a photo' do
    it 'succeeds' do
      author = create(:user)
      project = create(:project, author: author)
      log_in_as(author)
      visit project_path(project)
      within '#add_project_photo' do
        attach_file('project_photo_image', 'spec/support/stream01.jpg')
        fill_in 'Date of Photo', with: '01/01/2020'
        fill_in 'Description', with: 'Fake description'
        click_on 'Upload'
      end
      within '.project_photo' do
        click_on 'Edit'
      end
      fill_in 'Description', with: 'Updated Fake description'
      click_on 'Update'
      expect(page).to have_text project.name
      expect(page).to have_text 'Photo was successfully updated'
      expect(page).to have_text 'Updated Fake description'
    end
  end

  describe 'deleting a photo' do
    it 'succeeds' do
      author = create(:user)
      project = create(:project, author: author)
      log_in_as(author)
      visit project_path(project)
      within '#add_project_photo' do
        attach_file('project_photo_image', 'spec/support/stream01.jpg')
        fill_in 'Date of Photo', with: '01/01/2020'
        fill_in 'Description', with: 'Fake description'
        click_on 'Upload'
      end
      within '.project_photo' do
        click_on 'Delete'
      end
      expect(page).to have_text project.name
      expect(page).to have_text 'Photo was successfully removed'
      expect(page).to_not have_css("img[src*='stream01.jpg']")
    end
  end

end
