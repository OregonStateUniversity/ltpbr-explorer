require 'rails_helper'

RSpec.describe 'Admin Edits an Organization', type: :feature do

  it 'succeeds when providing valid details' do
    organization = create(:organization)
    old_name = organization.name
    admin = create(:user, :admin)
    log_in_as(admin)
    visit edit_organization_path(organization)
    fill_in 'Name', with: 'Updated Fake Organization'
    click_on 'Save'
    expect(page).to have_text 'Organization was successfully updated'
    expect(page).to_not have_text old_name
    expect(page).to have_text 'Updated Fake Organization'
  end

  it 'fails when providing invalid details' do
    organization = create(:organization)
    admin = create(:user, :admin)
    log_in_as(admin)
    visit edit_organization_path(organization)
    fill_in 'Name', with: ''
    click_on 'Save'
    expect(page).to_not have_text 'Organization was successfully updated'
    expect(page).to have_text 'error prohibited this organization from being saved'
  end

end
