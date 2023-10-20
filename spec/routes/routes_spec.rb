require 'rails_helper'

RSpec.describe 'routes', type: :routing do
  it "routes / to static#home" do
    expect(get('/')).to route_to('static#home')
  end
end
