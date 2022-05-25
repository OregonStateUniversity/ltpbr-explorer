require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:stream_name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:implementation_date) }
    it { is_expected.to validate_presence_of(:primary_contact) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:narrative) }
    it { is_expected.to validate_presence_of(:structure_description) }
    it { is_expected.to validate_presence_of(:watershed) }
    it { is_expected.to validate_numericality_of(:length).only_integer.is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:latitude).is_greater_than(-90).is_less_than(90).with_message('must be in decimal notation') }
    it { is_expected.to validate_numericality_of(:longitude).is_greater_than(-180).is_less_than(180).with_message('must be in decimal notation') }
    it { is_expected.to validate_numericality_of(:number_of_structures).only_integer.is_greater_than(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  it 'has a title consisting of its stream name' do
    stream_name = 'Example Stream Name'
    project.stream_name = stream_name
    expect(project.title).to eq "Project on #{stream_name}"
  end

  describe 'generating lonlat before saving' do
    it 'matches the latitude and longitude' do
      project.latitude = 44.042969
      project.longitude = -121.333481
      project.run_callbacks :save
      expect(project.lonlat.y).to be(44.042969)
      expect(project.lonlat.x).to be(-121.333481)
    end

    it 'rounds values to a precision of 6' do
      project.latitude = 44.0429694
      project.longitude = -121.3334816
      project.run_callbacks :save
      expect(project.lonlat.y).to be(44.042969)
      expect(project.lonlat.x).to be(-121.333482)
    end
  end
end
