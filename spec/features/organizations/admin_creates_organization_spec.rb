require 'rails_helper'

RSpec.describe 'Admin Creates an Organization', type: :feature do

  it 'succeeds when providing valid details' do
    admin = create(:user, :admin)
    log_in_as(admin)
    visit new_organization_path
    fill_in 'Name', with: 'New Fake Organization'
    fill_in 'Description', with: 'New fake description.'
    fill_in 'Contact', with: 'New Fake Organization Contact'
    fill_in 'Website', with: 'https://example.com'
    attach_file('Logo', File.absolute_path('spec/support/image.jpg'))
    click_on 'Save'
    expect(page).to have_text 'Organization was successfully created'
    expect(page).to have_text 'New Fake Organization'
    expect(page).to have_text 'New fake description'
    expect(page).to have_text 'New Fake Organization Contact'
    expect(page).to have_text 'https://example.com'
  end

  it 'fails when providing invalid details' do
    admin = create(:user, :admin)
    log_in_as(admin)
    visit new_organization_path
    fill_in 'Name', with: ''
    fill_in 'Website', with: 'INVALID'
    click_on 'Save'
    expect(page).to_not have_text 'Organization was successfully created'
    expect(page).to have_text 'errors prohibited this organization from being saved'
  end

end
