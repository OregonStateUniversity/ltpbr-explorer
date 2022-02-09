require 'rails_helper'

RSpec.describe "affiliations/index", type: :view do
  before(:each) do
    assign(:affiliations, [
      Affiliation.create!(),
      Affiliation.create!()
    ])
  end

  it "renders a list of affiliations" do
    render
  end
end
