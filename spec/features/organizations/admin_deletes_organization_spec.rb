require 'rails_helper'

RSpec.describe 'Admin Deletes an Organization', type: :feature do

  it 'succeeds' do
    organization = create(:organization)
    admin = create(:user, :admin)
    log_in_as(admin)
    visit organizations_path
    click_on 'Delete'
    expect(page).to have_text 'Organization was successfully destroyed'
    expect(page).to_not have_text organization.name
  end

  skip 'is no longer affiliated with a project' do

  end

end
