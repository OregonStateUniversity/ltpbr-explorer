require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) { build(:project) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:affiliation) }
    it { is_expected.to validate_presence_of(:stream_name) }
    it { is_expected.to validate_presence_of(:implementation_date) }
    it { is_expected.to validate_presence_of(:primary_contact) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_numericality_of(:area).only_integer.is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:latitude).is_greater_than(-90).is_less_than(90) }
    it { is_expected.to validate_numericality_of(:longitude).is_greater_than(-180).is_less_than(180) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  describe 'project#assign_lonlat' do
    it 'should compose lonlat from longitude and latitude' do
      subject.longitude = 99.9
      subject.latitude = 88.8
      subject.run_callbacks :save
      expect(subject.lonlat.x).to be(99.9)
      expect(subject.lonlat.y).to be(88.8)
    end

    it 'should round values to a precision of 6' do
      subject.longitude = 99.1234567
      subject.latitude = 88.1234561
      subject.run_callbacks :save
      expect(subject.lonlat.x).to be(99.123457)
      expect(subject.lonlat.y).to be(88.123456)
    end
  end
end
