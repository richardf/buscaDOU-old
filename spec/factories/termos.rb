FactoryGirl.define do
  factory :termo do
    sequence(:conteudo) { |i| "foobar#{i}" }

    factory :termo_com_usuario do
      association :usuario

      factory :termo_com_codigo do
        sequence(:codigo) { |i| "#{i}AAAAAAAA#{i}" }
      end
    end
  end
end
