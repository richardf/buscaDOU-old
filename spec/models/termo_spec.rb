require 'rails_helper'

RSpec.describe Termo, type: :model do
  it { is_expected.to respond_to(:ativo?) }

  describe 'ao ser criado' do
    it { is_expected.not_to be_valid }

    it 'deve estar inativo' do
      expect(subject.ativo?).to be false
    end
  end


  it 'nao deve ser valido sem o conteudo' do
    subject.usuario = build(:usuario)
    subject.codigo = 'AAA'
    expect(subject.valid?).to be false
  end

  it 'nao deve ser valido sem o usuario' do
    subject.conteudo = 'bla'
    subject.codigo = 'AAA'
    expect(subject.valid?).to be false
  end


  describe 'ao cadastrar um novo termo' do

    it 'deve enviar um email de ativacao' do
      expect{create(:termo_com_usuario)}.to change {ActionMailer::Base.deliveries.size}.by 1
    end

    it 'deve gerar um codigo de ativacao' do
      termo = create(:termo_com_usuario)
      expect(termo.codigo).to_not be nil
    end

    it 'deve converter o termo para caixa baixa antes de salvar' do
      subject.conteudo = 'AEI1'
      expect{subject.send(:downcase_conteudo)}.to change { subject.conteudo }.to('aei1')
    end

    it 'deve dar erro ao cadastrar conteudo de mais de 100 caracteres' do

    end

    it 'deve dar erro ao cadastrar conteudo de menos de 4 caracteres' do
      termo = build(:termo_com_codigo)
      termo.conteudo = 'abc'
      termo.valid?
      expect(termo.errors.messages[:conteudo]).to include(/is too short/)
    end

    it 'deve dar erro ao cadastrar conteudo com mais de 100 caracteres' do
      termo = build(:termo_com_codigo)
      termo.conteudo = 'a' * 101
      termo.valid?
      expect(termo.errors.messages[:conteudo]).to include(/is too long/)
    end

  end


  describe 'ao ativar o termo' do

    it 'deve alterar a flag de ativo' do
      allow(subject).to receive(:save!).and_return(true)
      expect{subject.ativar!}.to change { subject.ativo }.from(false).to(true)
    end
  end


  describe 'ao desativar o termo' do
    let(:termo_ativo) { create(:termo_com_codigo, ativo: true) }

    it 'deve alterar a flag para inativo' do
      allow(termo_ativo).to receive(:save!).and_return(true)
      expect{termo_ativo.desativar!}.to change { termo_ativo.ativo }.from(true).to(false)
    end
  end
end
