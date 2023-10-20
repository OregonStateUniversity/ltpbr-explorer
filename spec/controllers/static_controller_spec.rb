require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  context 'As a non logged-in user' do

    describe 'GET :home' do
      specify { expect(get(:home)).to be_successful }
    end

    describe 'GET :about' do
      specify { expect(get(:about)).to be_successful }
    end
  end

end
