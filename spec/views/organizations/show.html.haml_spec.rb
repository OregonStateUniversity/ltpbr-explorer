require 'rails_helper'

RSpec.describe "organizations/show", type: :view do
  let(:project) { create(:project) }

  before(:each) do
    @project = assign(:project, create(
      :project, 
      id: 1
    ))
    @organization = assign(:organization, Organization.create!(id: 1))
    @affiliation = assign(:affiliation, Affiliation.create!(
      id: 1,
      project_id: 1,
      organization_id: 1
    ))
  end

  it "renders attributes in <p>" do
    # render
  end
end
