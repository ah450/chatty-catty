require 'rails_helper'

RSpec.describe Api::TokensController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  it 'should have a default duration' do
    post :create, format: :json, token: {email: user.email, password: user.password}
    expect(User.find_by_token(json_response[:token])).to eql user
  end
end
