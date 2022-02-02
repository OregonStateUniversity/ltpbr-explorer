require 'rails_helper'

RSpec.describe "affiliations/edit", type: :view do
  before(:each) do
    @affiliation = assign(:affiliation, Affiliation.create!())
  end

  it "renders the edit affiliation form" do
    render

    assert_select "form[action=?][method=?]", affiliation_path(@affiliation), "post" do
    end
  end
end
