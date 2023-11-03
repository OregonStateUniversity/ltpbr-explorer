require 'rails_helper'

RSpec.describe 'User Views Projects', type: :feature do

  describe 'viewing the list of projects' do
    context 'as a non-logged-in user' do
      it 'succeeds' do
        project = create(:project)
        visit projects_path
        expect(page).to have_text 'LT-PBR Projects'
        expect(page).to have_text project.name
      end
    end
  end

  describe 'viewing a project' do

    context 'as a non-logged-in user' do
      it 'succeeds' do
        project = create(:project)
        visit project_path(project)
        expect(page).to have_text project.name
      end
      it 'does not show edit, delete or manage links' do
        project = create(:project)
        visit project_path(project)
        expect(page).to have_text project.name
        expect(page).to_not have_link 'Edit'
        expect(page).to_not have_link 'Delete'
        expect(page).to_not have_link 'Manage Affiliations'
      end
    end

    context 'as a logged-in user who is not the project author' do
      it 'does not show edit, delete or manage links' do
        project = create(:project)
        user = create(:user)
        expect(project.author).to_not eq(user)
        log_in_as(user)
        visit project_path(project)
        expect(page).to have_text project.name
        expect(page).to_not have_link 'Edit', exact: true
        expect(page).to_not have_link 'Delete'
        expect(page).to_not have_link 'Manage Affiliations'
      end
    end

    context 'as a project author' do
      it 'shows edit, delete and manage links' do
        user = create(:user)
        project = create(:project, author: user)
        expect(project.authored_by?(user)).to be_truthy
        log_in_as(user)
        visit project_path(project)
        expect(page).to have_text project.name
        expect(page).to have_link 'Edit', exact: true
        expect(page).to have_link 'Delete'
        expect(page).to have_link 'Manage Affiliations'
      end
    end

    context 'as an admin' do
      it 'shows edit, delete and manage links' do
        admin = create(:user, :admin)
        project = create(:project)
        expect(project.authored_by?(admin)).to be_falsy
        log_in_as(admin)
        visit project_path(project)
        expect(page).to have_text project.name
        expect(page).to have_link 'Edit', exact: true
        expect(page).to have_link 'Delete'
        expect(page).to have_link 'Manage Affiliations'
      end
    end

  end

end
