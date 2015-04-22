require 'rails_helper'

RSpec.describe 'DOUIndex', type: :feature, elasticsearch: true do

  before(:all) do 
    DOUIndex.gateway.create_index! index: DOUIndex.index_name
    texto = ArquivoPDF.new('spec/data/dou.pdf').texto
    DOUIndex.create(conteudo: texto, data: Date.today, secao: 2, pagina: 54)
    sleep 1
  end

  after(:all) do
    DOUIndex.gateway.client.indices.delete index: DOUIndex.index_name
  end

  it 'deve localizar um termo existente no indice' do
    res = DOUIndex.procurar_por('FUCHSHUBER', Date.today)
    expect(res.total).to eq(1)
  end

  it 'deve pesquisar um termo como uma frase' do
    res = DOUIndex.procurar_por('Esta Portaria entra em vigor', Date.today)
    expect(res.hits.first.highlight.conteudo.size).to eq(3)
  end

  it 'deve ignorar caixa alta / baixa' do
    res = DOUIndex.procurar_por('FuchsHUBeR', Date.today)
    expect(res.total).to eq(1)
  end

  it 'nao deve localizar um termo nao existente' do
    res = DOUIndex.procurar_por('essetermodebuscanaoexiste', Date.today)
    expect(res.total).to eq(0)
  end

  it 'deve retornar data, secao, pagina e destaque' do
    res = DOUIndex.procurar_por('FUCHSHUBER', Date.today)
    expect(res.hits[0].fields).to include('data')
    expect(res.hits[0].fields).to include('pagina')
    expect(res.hits[0].fields).to include('secao')
    expect(res.hits[0]).to include('highlight')
  end
end