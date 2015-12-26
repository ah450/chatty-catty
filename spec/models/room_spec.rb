require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) {FactoryGirl.build(:room)}
  it 'has a valid factory' do
    expect(room).to be_valid
  end
  context 'when name is nil' do
    let(:room) {FactoryGirl.build(:room, name: nil)}
    it 'is not valid' do
      expect(room).to_not be_valid
    end
  end
  context 'when user is nil' do
    let(:room) {FactoryGirl.build(:room, user: nil)}
    it 'is not valid' do
      expect(room).to_not be_valid
    end
  end

  context 'unique names' do
    let(:first) {FactoryGirl.create(:room)}
    let(:second) {FactoryGirl.build(:room)}
    it 'should disallow duplicate names' do
      second.name = first.name
      expect(second).to_not be_valid
    end
  end
end
