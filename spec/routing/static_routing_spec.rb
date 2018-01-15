require 'rails_helper'

RSpec.describe StaticController, type: :routing do
  describe 'routes static pages' do
    it 'routes to #home' do
      expect(get: '/').to route_to(controller: 'static', action: 'home')
    end
  end
end
