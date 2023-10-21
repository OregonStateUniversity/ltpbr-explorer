require 'rails_helper'

RSpec.describe State, type: :model do
  let(:state) { build(:state) }

  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:iso_code) }
    it { is_expected.to respond_to(:geom) }
    it { is_expected.to respond_to(:projects_count) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:iso_code) }
    it { is_expected.to validate_presence_of(:geom) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects).dependent(:restrict_with_error) }
  end

  describe 'number_of_structures' do
    # See https://github.com/OregonStateUniversity/bda-explorer/issues/310
    skip 'should be total number of structures for all associated projects' do
      expect(state_with_projects.number_of_structures).to eq(6)
    end
  end

  describe 'project_total_length_km' do
    # See https://github.com/OregonStateUniversity/bda-explorer/issues/310
    skip 'should be total length in kilometers for all associated projects' do
      expect(state_with_projects.project_total_length_km).to eq('TODO')
    end
  end

  describe 'project_total_length_mi' do
    # See https://github.com/OregonStateUniversity/bda-explorer/issues/310
    skip 'should be total length in miles for all associated projects' do
      expect(state_with_projects.project_total_length_mi).to eq('TODO')
    end
  end

end
