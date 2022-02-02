require 'rails_helper'

RSpec.describe "affiliations/new", type: :view do
  before(:each) do
    assign(:affiliation, Affiliation.new())
  end

  it "renders new affiliation form" do
    render

    assert_select "form[action=?][method=?]", affiliations_path, "post" do
    end
  end
end
