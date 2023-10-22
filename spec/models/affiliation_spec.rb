require 'rails_helper'

RSpec.describe Affiliation, type: :model do
  let(:affiliation) { build(:affiliation) }

  describe 'attributes' do
    it { is_expected.to respond_to(:role) }
  end

  describe 'validations' do
    subject { build(:affiliation) }
    it { is_expected.to validate_uniqueness_of(:organization_id).scoped_to(:project_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to belong_to(:project) }
  end

end
