require 'rails_helper'

RSpec.describe State, type: :model do
  let(:state) { build(:state) }

  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:iso_code) }
    it { is_expected.to respond_to(:geom) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:iso_code) }
    it { is_expected.to validate_presence_of(:geom) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects).dependent(:restrict_with_error) }
  end

end
