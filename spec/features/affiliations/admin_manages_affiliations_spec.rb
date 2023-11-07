require 'rails_helper'

RSpec.describe 'Admin Manages Affiliations', type: :feature do

  describe 'viewing the list' do
    it 'shows the organization name and role for each affiliation' do
      project = create(:project)
      affiliation = create(:affiliation, project: project)
      admin = create(:user, :admin)
      log_in_as(admin)
      visit project_affiliations_path(project)
      expect(page).to have_text "Organization Affiliations"
      within "#affiliation_#{affiliation.id}" do
        expect(page).to have_text affiliation.organization.name
        expect(page).to have_text affiliation.role
      end
      expect(page).to have_text "Add an Organization Affiliation"
    end
  end

  describe 'adding an affiliation' do
    it 'succeeds' do
      project = create(:project)
      admin = create(:user, :admin)
      organization = create(:organization)
      log_in_as(admin)
      visit project_affiliations_path(project)
      within "#new_affiliation" do
        select organization.name, from: :affiliation_organization_id
        fill_in :affiliation_role, with: 'Fake Role'
        click_on 'Create Affiliation'
      end
      expect(page).to have_text 'Affiliation was successfully created'
      expect(page).to have_text organization.name
      expect(page).to have_text 'Fake Role'
    end

    it 'fails when an organization is not specified' do
      project = create(:project)
      admin = create(:user, :admin)
      organization = create(:organization)
      log_in_as(admin)
      visit project_affiliations_path(project)
      within "#new_affiliation" do
        click_on 'Create Affiliation'
      end
      expect(page).to have_text 'Error'
    end
  end

  describe 'editing an affiliation' do
    it 'succeeds' do
      project = create(:project)
      affiliation = create(:affiliation, project: project)
      admin = create(:user, :admin)
      log_in_as(admin)
      visit edit_project_affiliation_path(project, affiliation)
      fill_in :affiliation_role, with: 'Updated Fake Role'
      click_on 'Update Affiliation'
      expect(page).to have_text 'Affiliation was successfully updated'
      within "#affiliation_#{affiliation.id}" do
        expect(page).to have_text 'Updated Fake Role'
      end
    end
  end

  describe 'deleting an affiliation' do
    it 'succeeds' do
      project = create(:project)
      affiliation = create(:affiliation, project: project, role: 'Deletable')
      admin = create(:user, :admin)
      log_in_as(admin)
      visit project_affiliations_path(project)
      within "#affiliation_#{affiliation.id}" do
        click_on 'Delete'
      end
      expect(page).to have_text 'Affiliation was successfully deleted'
      expect(page).to_not have_text 'Deletable'
    end
  end

end
