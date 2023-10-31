require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'attributes' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:username) }
    it { is_expected.to respond_to(:affiliation) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:role) }
    it { is_expected.to respond_to(:projects_count) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:affiliation) }
    it { is_expected.to validate_presence_of(:role) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects) }
  end

end
