require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:affiliation) }
    it { is_expected.to validate_presence_of(:stream_name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:implementation_date) }
    it { is_expected.to validate_presence_of(:primary_contact) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:latitude) }
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

  describe 'byline' do
    it 'consists of a date' do
      expect(project.byline).to match /Implemented on #{Date.today.to_formatted_s(:long)}/
    end
    context 'with an affiliation' do
      it 'consists of a date and affiliation' do
        expect(project.byline).to eq "Implemented on #{Date.today.to_formatted_s(:long)} in affiliation with Example Affiliation"
      end
    end
  end

  describe 'generating lonlat before saving' do
    it 'matches the latitude and longitude' do
      project.latitude = 88.8
      project.longitude = 99.9
      project.run_callbacks :save
      expect(project.lonlat.x).to be(99.9)
      expect(project.lonlat.y).to be(88.8)
    end

    it 'rounds values to a precision of 6' do
      project.latitude = 88.1234561
      project.longitude = 99.1234567
      project.run_callbacks :save
      expect(project.lonlat.x).to be(99.123457)
      expect(project.lonlat.y).to be(88.123456)
    end
  end
end
