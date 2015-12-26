FactoryGirl.define do
  factory :room do
    name {Faker::Team.name}
    user {FactoryGirl.create(:user)}
  end

end
