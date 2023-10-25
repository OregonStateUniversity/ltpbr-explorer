require 'rails_helper'

RSpec.describe 'User Views Organizations', type: :feature do

  it 'succeeds when viewing the list' do
    organization = create(:organization)
    visit organizations_path
    expect(page).to have_text 'Organizations'
    expect(page).to have_text organization.name
  end

  it 'succeeds when viewing a single organization' do
    organization = create(:organization)
    visit organization_path(organization)
    expect(page).to have_text organization.name
  end

  it 'does not show new, edit or delete links in the list' do
    organization = create(:organization)
    visit organizations_path
    expect(page).to have_text 'Organizations'
    expect(page).to_not have_link 'New Organization'
    expect(page).to_not have_link 'Edit'
    expect(page).to_not have_link 'Delete'
  end

  it 'does not show edit or delete links when viewing a single organization' do
    organization = create(:organization)
    visit organization_path(organization)
    expect(page).to have_text organization.name
    expect(page).to_not have_link 'Edit'
    expect(page).to_not have_link 'Delete'
  end

end
