require 'rails_helper'

RSpec.describe "organizations/index", type: :view do
  include Devise::Test::ControllerHelpers

  before(:each) do
    assign(:organizations, [
      Organization.create!(description: "Example description 1"),
      Organization.create!(description: "Example description 1")
    ])
  end

  it "renders a list of organizations" do
    render
  end
end
