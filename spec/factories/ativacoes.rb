FactoryGirl.define do
  factory :ativacao do
    sequence(:codigo) { |i| "#{i}000000#{i}" }
    association :termo, strategy: :build

    factory :ativacao_com_termo do
      association :termo, factory: :termo_com_usuario
    end
  end
end