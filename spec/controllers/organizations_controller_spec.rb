require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  context 'As a non logged-in user' do
    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(new_user_session_path) }
    end

    describe 'GET #edit' do
      specify { expect(get(:edit, params: {id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'POST #create' do
      specify { expect(post(:create)).to redirect_to(new_user_session_path) }
    end

    describe 'PUT #update' do
      specify { expect(put(:update, params: {id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'PATCH #update' do
      specify { expect(patch(:update, params: {id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'DELETE #destroy' do
      specify { expect(delete(:destroy, params: {id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end
  end

  context 'As a non-admin user' do
    let(:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe 'GET #new' do
      specify { expect(get(:new)).to redirect_to(root_path) }
    end

    describe 'GET #edit' do
      specify { expect(get(:edit, params: {id: 'FAKE'})).to redirect_to(root_path) }
    end

    describe 'POST #create' do
      specify { expect(post(:create)).to redirect_to(root_path) }
    end

    describe 'PUT #update' do
      specify { expect(put(:update, params: {id: 'FAKE'})).to redirect_to(root_path) }
    end

    describe 'PATCH #update' do
      specify { expect(patch(:update, params: {id: 'FAKE'})).to redirect_to(root_path) }
    end

    describe 'DELETE #destroy' do
      specify { expect(delete(:destroy, params: {id: 'FAKE'})).to redirect_to(root_path) }
    end
  end

end
