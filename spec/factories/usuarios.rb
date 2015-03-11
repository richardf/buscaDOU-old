FactoryGirl.define do
  factory :usuario do
    sequence(:email) { |i| "eu#{i}@gmail.com" }
  end
end
