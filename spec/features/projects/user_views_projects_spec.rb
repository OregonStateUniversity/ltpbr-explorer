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
      it 'provides a csv export' do
        project = create(:project)
        visit projects_path(format: :csv)
        expect(page.text).to match /id,.*,name,.*/
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
        expect(page).to_not have_link 'Add a cover photo'
        expect(page).to_not have_link 'Modify cover photo'
        expect(page).to_not have_text 'Add a Photo'
        expect(page).to_not have_selector '#add_project_photo'
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
        expect(page).to_not have_link 'Add a cover photo'
        expect(page).to_not have_link 'Modify cover photo'
        expect(page).to_not have_text 'Add a Photo'
        expect(page).to_not have_selector '#add_project_photo'
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
        expect(page).to have_link 'Add a cover photo'
        expect(page).to have_link 'Modify cover photo'
        expect(page).to have_text 'Add a Photo'
        expect(page).to have_selector '#add_project_photo'
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
        expect(page).to have_link 'Add a cover photo'
        expect(page).to have_link 'Modify cover photo'
        expect(page).to have_text 'Add a Photo'
        expect(page).to have_selector '#add_project_photo'
      end
    end
  end

  describe 'filtering the project list' do
    context 'without triggering the filter' do
      it 'returns all projects' do
        first_project = create(:project, name: 'First')
        second_project = create(:project, name: 'Second')
        visit projects_path
        expect(page).to have_text('2 Projects')
        within '.projects' do
          expect(page).to have_text(first_project.name)
          expect(page).to have_text(second_project.name)
        end
      end
    end
    context 'triggering the filter with blank values' do
      it 'returns all projects' do
        first_project = create(:project, name: 'First')
        second_project = create(:project, name: 'Second')
        visit projects_path
        click_on 'Filter'
        expect(page).to have_text('2 Projects')
        within '.projects' do
          expect(page).to have_text(first_project.name)
          expect(page).to have_text(second_project.name)
        end
      end
    end
    context 'query nor organization match' do
      it 'displays an empty page' do
        project = create(:project, name: 'Yes', watershed: 'Yes', stream_name: 'Yes')
          project.affiliations << create(:affiliation, organization: create(:organization))
        organization = create(:organization, name: 'Yes')
        visit projects_path
        fill_in :query, with: 'Yes'
        select organization.name, from: :organization_id
        click_on 'Filter'
        expect(page).to have_text('0 Projects')
        within '.projects' do
          expect(page).to_not have_text(project.name)
        end
      end
    end
    context 'with a query but no organization' do
      it 'includes a project whose name matches the query' do
        found_project = create(:project, name: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization))
        unfound_project = create(:project, name: 'No')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization))
        visit projects_path
        fill_in :query, with: found_project.name
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.name)
          expect(page).to_not have_text(unfound_project.name)
        end
      end
      it 'includes a project whose watershed matches the query' do
        found_project = create(:project, watershed: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization))
        unfound_project = create(:project, watershed: 'No')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization))
        visit projects_path
        fill_in :query, with: found_project.watershed
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.watershed)
          expect(page).to_not have_text(unfound_project.watershed)
        end
      end
      it 'includes a project whose stream_name matches the query' do
        found_project = create(:project, stream_name: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization))
        unfound_project = create(:project, stream_name: 'No')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization))
        visit projects_path
        fill_in :query, with: found_project.stream_name
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.stream_name)
          expect(page).to_not have_text(unfound_project.stream_name)
        end
      end
    end
    context 'with an organization but no query' do
      it 'includes a project matching the organization' do
        found_project = create(:project, name: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization, name: 'Yes'))
        unfound_project = create(:project, name: 'No')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization, name: 'No'))
        visit projects_path
        select found_project.organizations.first.name, from: :organization_id
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.name)
          expect(page).to_not have_text(unfound_project.name)
        end
      end
    end
    context 'with both query and organization are present' do
      it 'includes a project whose name and organization matches the query' do
        found_project = create(:project, name: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization, name: 'Yes'))
        unfound_project = create(:project, name: 'Yes')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization, name: 'No'))
        visit projects_path
        fill_in :query, with: 'Yes'
        select found_project.organizations.first.name, from: :organization_id
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.name)
          expect(page).to_not have_text('No') # Project with same name but different organization
        end
      end
      it 'includes a project whose watershed and organization id matches the query' do
        found_project = create(:project, watershed: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization, name: 'Yes'))
        unfound_project = create(:project, watershed: 'Yes')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization, name: 'No'))
        visit projects_path
        fill_in :query, with: 'Yes'
        select found_project.organizations.first.name, from: :organization_id
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.name)
          expect(page).to_not have_text('No') # Project with same watershed but different organization
        end
      end
      it 'includes a project whose stream_name and organization id matches the query' do
        found_project = create(:project, stream_name: 'Yes')
          found_project.affiliations << create(:affiliation, organization: create(:organization, name: 'Yes'))
        unfound_project = create(:project, stream_name: 'Yes')
          unfound_project.affiliations << create(:affiliation, organization: create(:organization, name: 'No'))
        visit projects_path
        fill_in :query, with: 'Yes'
        select found_project.organizations.first.name, from: :organization_id
        click_on 'Filter'
        expect(page).to have_text('1 Project')
        within '.projects' do
          expect(page).to have_text(found_project.name)
          expect(page).to_not have_text('No') # Project with same stream_name but different organization
        end
      end
    end
  end

end
