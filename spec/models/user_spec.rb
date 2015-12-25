require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.build(:user)}
  it 'has a valid factory' do
    expect(user).to be_valid
  end
  context 'when email is nil' do
    let(:user) {FactoryGirl.build(:user, email: nil)}
    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end
  context 'when password is nil' do
    let(:user) {FactoryGirl.build(:user, password: nil)}
    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end
  context 'when password is less than two characters' do
    let(:user) {FactoryGirl.build(:user, password: 's')}
    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end
  context 'unique emails' do
    let(:first) {FactoryGirl.create(:user)}
    let(:second) {FactoryGirl.build(:user)}
    it 'should disallow duplicate emails' do
      second.email = first.email
      expect(second).to_not be_valid
    end
    it 'should perform case insensitive check' do
      second.email = first.email.upcase
      expect(second).to_not be_valid
    end
  end
end
