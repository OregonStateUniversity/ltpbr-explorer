require 'rails_helper'

RSpec.describe 'Author Deletes a Project', type: :feature do

  it 'succeeds' do
    author = create(:user)
    project = create(:project, author: author)
    log_in_as(author)
    visit project_path(project)
    click_on 'Delete'
    expect(page).to_not have_text project.name
    expect(page).to have_text 'Project was successfully destroyed'
  end

end
