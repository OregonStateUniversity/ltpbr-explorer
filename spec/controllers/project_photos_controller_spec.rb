require 'rails_helper'

RSpec.describe ProjectPhotosController, type: :controller do

  context 'As a non logged-in user' do

    describe 'PUT #create' do
      specify { expect(put(:create, params: {project_id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'GET #edit' do
      specify { expect(get(:edit, params: {project_id: 'FAKE', id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'PUT #update' do
      specify { expect(put(:update, params: {project_id: 'FAKE', id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'PATCH #update' do
      specify { expect(patch(:update, params: {project_id: 'FAKE', id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end

    describe 'DELETE #destroy' do
      specify { expect(delete(:destroy, params: {project_id: 'FAKE', id: 'FAKE'})).to redirect_to(new_user_session_path) }
    end
  end

  context 'As a non-admin user who does not own the project' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe 'PUT #create' do
      specify { expect(put(:create, params: {project_id: project.id})).to redirect_to(root_path) }
    end

    describe 'GET #edit' do
      specify { expect(get(:edit, params: {project_id: project.id, id: 'FAKE'})).to redirect_to(root_path) }
    end

    describe 'PUT #update' do
      specify { expect(put(:update, params: {project_id: project.id, id: 'FAKE'})).to redirect_to(root_path) }
    end

    describe 'PATCH #update' do
      specify { expect(patch(:update, params: {project_id: project.id, id: 'FAKE'})).to redirect_to(root_path) }
    end

    describe 'DELETE #destroy' do
      specify { expect(delete(:destroy, params: {project_id: project.id, id: 'FAKE'})).to redirect_to(root_path) }
    end
  end

end
