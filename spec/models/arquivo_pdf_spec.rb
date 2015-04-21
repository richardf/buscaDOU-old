require 'rails_helper'

RSpec.describe ArquivoPDF, type: :model do
  subject {ArquivoPDF.new('spec/data/dou.pdf')}

  it { is_expected.to respond_to(:texto) }
  it { is_expected.to respond_to(:numero_paginas) }


  context 'arquivo inexistente' do
    it 'deve lancar excecao' do
      expect{ ArquivoPDF.new('spec/nao_existe.pdf') }.to raise_error
    end
  end

  it 'deve retornar o numero de paginas' do
    expect(subject.numero_paginas).to eq 1
  end

  it 'deve retornar o texto do pdf' do 
    expect(subject.texto).to include('O Chefe da Unidade Avançada')
  end

  it 'deve remover quebras de linha' do 
    expect(subject.texto).not_to include("\n")
  end

  it 'deve adicionar um espaco entre palavras separadas por quebra de linha' do
    expect(subject.texto).to include('JONATAS CASTRO DOS SANTOS')
  end

  it 'deve juntar palavra dividida por quebra de linha' do
    expect(subject.texto).to include('TATIANA GONÇALVES MUZI')
  end

end