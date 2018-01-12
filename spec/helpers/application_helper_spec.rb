require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it 'returns the base title without arguments' do
      expect(helper.full_title).to eq('BDAdb');
    end
  end
end