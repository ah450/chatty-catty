require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'index' do
    let(:users) {FactoryGirl.create_list(:user, 10)}
    it 'should respond to index action' do
      get :index, format: :json
      expect(response).to be_success
    end
    it 'should have pagination' do
      get :index, format: :json, page: 1, page_size: users.length / 2
      expect(json_response).to include(
        :users, :page, :page_size, :total_pages
        )
      expect(json_response[:users].length).to eql users.length / 2
    end
    it 'should return all records' do
      get :index, format: :json, page: 1, page_size: users.length
      expect(json_response).to include(
        :users, :page, :page_size, :total_pages
        )
      expect(json_response[:total_pages]).to eql 1
      expect(json_response[:page_size]).to eql users.length
      are_equal = json_response[:users].zip(users).reduce {
        |memo, (lhs, rhs)| lhs[:id] == rhs.id}
      expect(are_equal).to be true
    end
  end

  describe 'show' do
    let(:user) {FactoryGirl.create(:user)}
    it 'shows the correct user' do
      get :show, format: :json,  id: user.id
      expect(json_response[:id]).to eq user.id
      expect(json_response).to include(
        :id, :email, :username, :created_at, :updated_at
        )
      expect(json_response).to_not include(:password_digest)
    end
  end

  describe 'update' do
    let(:user) {FactoryGirl.create(:user)}
    let(:other) {FactoryGirl.create(:user)}
    it 'Should not allow unauthorized updates' do
      old_digest = user.password_digest
      put :update, id: user.id, user: {password: "new password!"}
      expect(response).to be_unauthorized
      user.reload
      expect(user.password_digest).to eql old_digest
    end
    it 'Should allow an authorized user to change its own password' do
      request.headers['Authorization'] = "Bearer #{user.token}"
      old_digest = user.password_digest
      put :update, id: user.id, user: {password: "new password!"}
      expect(response).to be_success
      user.reload
      expect(user.password_digest).to_not eql old_digest
    end
    it "should not allow a user to change another's password" do
      request.headers['Authorization'] = "Bearer #{other.token}"
      old_digest = user.password_digest
      put :update, id: user.id, user: {password: "new password!"}
      expect(response).to be_forbidden
      user.reload
      expect(user.password_digest).to eql old_digest
    end
  end

  describe 'create' do
    context 'with valid params' do
      let(:user_params) {FactoryGirl.attributes_for(:user)}
      it 'should create a new user' do
        expect {
          post :create, format: :json, user: user_params
        }.to change(User, :count).by 1
        expect(response).to be_created
      end
    end
    context 'with invalid params' do
      let(:user_params) {FactoryGirl.attributes_for(:user, password: 's')}
      it 'shouldnt create a new user' do
        expect {
          post :create, format: :json, user: user_params
        }.to change(User, :count).by 0
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'destroy' do
    it 'should not be routable' do
      expect( delete: 'api/users/1').to_not be_routable
    end
  end
end
