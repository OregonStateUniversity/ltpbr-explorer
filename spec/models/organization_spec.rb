require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { build(:organization) }

  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:contact) }
    it { is_expected.to respond_to(:website) }
    it { is_expected.to respond_to(:affiliations_count)}
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it {
      is_expected.to allow_value('https://example.com').for(:website)
      is_expected.to allow_value('').for(:website)
      is_expected.to allow_value(nil).for(:website)
    }
    it { is_expected.to validate_content_type_of(:logo) }
    it { is_expected.to validate_size_of(:logo).less_than(50.megabytes) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:affiliations).dependent(:delete_all) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_one_attached(:logo) }
  end

  describe 'to_csv' do
    it 'returns a csv string with attributes values' do
      create(:organization, name: 'First')
      create(:organization, name: 'Second')
      organizations_csv = Organization.to_csv
      expect(organizations_csv).to match /id,name.*\n.*,First,.*\n.*,Second,.*/
    end
  end

end
