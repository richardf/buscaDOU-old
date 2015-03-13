FactoryGirl.define do
  factory :ativacao do
    sequence(:codigo) { |i| "#{i}000000#{i}" }
    association :termo, strategy: :build
  end
end