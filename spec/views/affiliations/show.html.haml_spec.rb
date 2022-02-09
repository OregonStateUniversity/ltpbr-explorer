require 'rails_helper'

RSpec.describe "affiliations/show", type: :view do
  before(:each) do
    @affiliation = assign(:affiliation, Affiliation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
