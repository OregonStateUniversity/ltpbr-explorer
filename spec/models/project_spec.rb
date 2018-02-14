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
  end

end
