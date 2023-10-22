require 'rails_helper'
require 'hash' # See lib/hash.rb

RSpec.describe Hash, type: :model do

  describe 'accumulate' do
    it 'returns a new hash with each value beig a cumulation of the others' do
      example = {a: 1, b: 3, c: 5, d: 7}
      expect(example.accumulate).to eq({a: 1, b: 4, c: 9, d: 16})
    end
  end

end
