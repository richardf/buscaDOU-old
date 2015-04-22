require 'rails_helper'

RSpec.describe 'BuscaTermosJob', type: [:feature, :mailer], elasticsearch: true do
  subject { BuscaTermosJob }

  before(:all) do 
    DOUIndex.gateway.create_index! index: DOUIndex.index_name
    texto = ArquivoPDF.new('spec/data/dou.pdf').texto
    DOUIndex.create(conteudo: texto, data: Date.today, secao: 2, pagina: 54)
    sleep 1
  end

  after(:all) do
    DOUIndex.gateway.client.indices.delete index: DOUIndex.index_name
  end

  it 'deve enviar email ao encontrar uma ocorrencia' do
    termo = create(:termo_com_usuario, ativo: true)
    termo.conteudo = 'fuchshuber'
    termo.save
    expect {subject.perform_now(termo.usuario.id, Date.today)}.to change{ActionMailer::Base.deliveries.size}.by 1
  end

  it 'nao deve enviar email se nao encontrar ocorrencias' do
    termo = create(:termo_com_usuario, ativo: true)
    expect {subject.perform_now(termo.usuario.id, Date.today)}.not_to change{ActionMailer::Base.deliveries.size}
  end
end