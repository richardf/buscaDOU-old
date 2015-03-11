FactoryGirl.define do
  factory :termo do
    sequence(:conteudo) { |i| "foobar#{i}" }

    factory :termo_com_usuario do
      association :usuario
    end
  end
end
