require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { build(:organization) }

  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:contact) }
    it { is_expected.to respond_to(:website) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to allow_value('https://example.com').for(:website) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:affiliations).dependent(:delete_all) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_one_attached(:logo) }
  end

  describe 'TODO' do
    skip 'TODO' do
      expect('TODO').to eq(6)
    end
  end

end
