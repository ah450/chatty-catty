require 'rails_helper'

RSpec.describe Api::RoomsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  describe 'index' do
    let(:rooms) {FactoryGirl.create_list(:room, 10)}
    it 'should respond to index action' do
      request.headers['Authorization'] = "Bearer #{user.token}"
      get :index, format: :json
      expect(response).to be_success
    end
    it 'should not respond to unauthorized requests' do
      get :index, format: :json
      expect(response).to be_unauthorized
    end
    it 'should have pagination' do
      request.headers['Authorization'] = "Bearer #{user.token}"
      get :index, format: :json, page: 1, page_size: rooms.length / 2
      expect(json_response).to include(
        :rooms, :page, :page_size, :total_pages
        )
      expect(json_response[:rooms].length).to eql rooms.length / 2
    end
    it 'should return all records' do
      request.headers['Authorization'] = "Bearer #{user.token}"
      get :index, format: :json, page: 1, page_size: rooms.length
      expect(json_response).to include(
        :rooms, :page, :page_size, :total_pages
        )
      expect(json_response[:total_pages]).to eql 1
      expect(json_response[:page_size]).to eql rooms.length
      are_equal = json_response[:rooms].zip(rooms).reduce {
        |memo, (lhs, rhs)| lhs[:id] == rhs.id}
      expect(are_equal).to be true
    end
  end

  describe 'show' do
    let(:room) {FactoryGirl.create(:room)}
    it 'shows the correct user' do
      request.headers['Authorization'] = "Bearer #{user.token}"
      get :show, format: :json,  id: room.id
      expect(json_response[:id]).to eq room.id
      expect(json_response).to include(
        :id, :name, :created_at, :updated_at, :user_id
        )
    end
    it 'should not respond to unauthorized request' do
      get :show, format: :json,  id: room.id
      expect(response).to be_unauthorized
    end
  end

  describe 'create' do
    let(:room) {FactoryGirl.attributes_for(:room)}
    it 'should not respond to unauthorized request' do
      expect {
        post :create, format: :json,  room: room
      }.to change(Room, :count).by 0
      expect(response).to be_unauthorized
    end
    it 'should set the correct owner' do
      request.headers['Authorization'] = "Bearer #{user.token}"
      expect {
        post :create, format: :json,  room: room
      }.to change(Room, :count).by 1
      expect(json_response[:user_id]).to eql user.id
    end
    it 'should validate name' do
      room[:name] = nil
      request.headers['Authorization'] = "Bearer #{user.token}"
      expect {
        post :create, format: :json,  room: room
      }.to change(Room, :count).by 0
      expect(response).to be_unprocessable
    end
    context 'duplicate names' do
      let(:room) {FactoryGirl.create(:room)}
      let(:data) {FactoryGirl.attributes_for(:room)}
      it 'should reject duplicate name' do
        request.headers['Authorization'] = "Bearer #{user.token}"
        data[:name] = room.name
        expect {
          post :create, format: :json,  room: data
        }.to change(Room, :count).by 0
      end
    end

    describe 'destroy' do
      it 'should not be routable' do
        expect( delete: 'api/rooms/1').to_not be_routable
      end
    end

    describe 'update' do
      it 'should not be routable' do
        expect( put: 'api/rooms/1').to_not be_routable
        expect( patch: 'api/rooms/1').to_not be_routable
      end
    end
  end

end
