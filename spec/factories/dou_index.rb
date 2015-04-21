FactoryGirl.define do
  factory :DOUIndex do
    sequence(:conteudo) { |i| "conteudo a ser indexado" }
    sequence(:pagina) { |i| i }
    sequence(:secao) { |i| i }
    data { Time.zone.now }
  end
end
