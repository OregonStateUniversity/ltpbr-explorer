require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context 'As a non logged-in user' do

    describe 'GET #show' do
      specify { expect(get(:show, params: {id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

  end

end
