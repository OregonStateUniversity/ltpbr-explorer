require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }

  describe 'attributes' do
    it { is_expected.to respond_to(:affiliation_legacy) }
    it { is_expected.to respond_to(:stream_name) }
    it { is_expected.to respond_to(:implementation_date) }
    it { is_expected.to respond_to(:narrative) }
    it { is_expected.to respond_to(:length) }
    it { is_expected.to respond_to(:primary_contact) }
    it { is_expected.to respond_to(:lonlat) }
    it { is_expected.to respond_to(:number_of_structures) }
    it { is_expected.to respond_to(:structure_description) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:watershed) }
    it { is_expected.to respond_to(:url) }
    skip("replace with new attachment association") { is_expected.to respond_to(:cover_photo) }
    it { is_expected.to respond_to(:affiliations_count) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:stream_name) }
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
    it { is_expected.to validate_content_type_of(:photos) }
    it { is_expected.to validate_size_of(:photos).less_than(50.megabytes) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
    it { is_expected.to belong_to(:state).optional }
    it { is_expected.to have_many(:affiliations) }
    it { is_expected.to have_many(:organizations).through(:affiliations) }
    it { is_expected.to have_many_attached(:photos) }
  end

  describe 'project_total_length_km' do
    it 'is 0 when there are no projects in the database' do
      expect(Project.count).to eq(0)
      expect(Project.project_total_length_km).to eq(0)
    end
    it 'is 0 when the lengths are 49m or less' do
      create(:project, length: 49)
      expect(Project.project_total_length_km).to eq(0)
    end
    it 'is the total sum of all project lengths in km' do
      2.times { create(:project, length: 100) }
      expect(Project.project_total_length_km).to eq(0.2)
    end
  end

  describe 'project_total_length_mi' do
    it 'is 0 when there are no projects in the database' do
      expect(Project.count).to eq(0)
      expect(Project.project_total_length_mi).to eq(0)
    end
    it 'is 0 when the lengths are less than 149m' do
      create(:project, length: 149)
      expect(Project.project_total_length_mi).to eq(0)
    end
    it 'is the total sum of all project lengths in miles' do
      2.times { create(:project, length: 100) }
      expect(Project.project_total_length_mi).to eq(0.1)
    end
  end

  describe 'to_s' do
    it 'is its name' do
      expect(project.to_s).to eq project.name
    end
  end

  describe 'authored_by?' do
    context 'when the project author is the user' do
      it 'is true' do
        user = build(:user)
        project.author = user
        expect(project.authored_by?(user)).to be_truthy
      end
    end
    context 'when the project author is not the user' do
      it 'is false' do
        user = build(:user)
        expect(Project.new.authored_by?(user)).to be_falsy
      end
    end
  end

  describe 'calculate_state' do
    context 'when the lonlat is nil' do
      it 'returns nil' do
        project.lonlat = nil
        expect(project.calculate_state).to be_nil
      end
    end

    context 'when the lonlat is not in a US state' do
      it 'returns nil' do
        project.latitude = 45.424721
        project.longitude = -75.695
        expect(project.calculate_state).to be_nil
      end
    end

    context 'when the lonlat is in a US state' do
      skip("see #306. returns an id") do
        create(:state)
        project.assign_lonlat
        expect(project.calculate_state).to_not be_nil
      end
    end
  end

  describe 'lonlat' do
    context 'assigning lonlat before saving' do
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

      it 'returns false if latitude or longitude are missing' do
        project.latitude = 44.0429694
        project.longitude = nil
        expect(project.run_callbacks(:save)).to be_falsy
        expect(project.lonlat).to be(nil)
        project.latitude = nil
        project.longitude = -121.3334816
        expect(project.run_callbacks(:save)).to be_falsy
        expect(project.lonlat).to be(nil)
      end
    end
  end

end
