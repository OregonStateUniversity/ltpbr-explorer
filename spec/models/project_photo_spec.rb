require 'rails_helper'

RSpec.describe ProjectPhoto, type: :model do
  let(:project_photo) { build(:project_photo) }

  describe 'attributes' do
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:date) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_content_type_of(:image) }
    it { is_expected.to validate_size_of(:image).less_than(50.megabytes) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_one_attached(:image) }
  end
end
