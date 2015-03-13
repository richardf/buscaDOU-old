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
    expect(subject.valid?).to be false
  end

  it 'nao deve ser valido sem o usuario' do
    subject.conteudo = 'bla'
    expect(subject.valid?).to be false
  end

  it 'deve poder ser ativado' do
    allow(subject).to receive(:save!).and_return(true)
    expect{subject.ativar!}.to change { subject.ativo }.from(false).to(true)
  end

  it 'deve converter o termo para caixa baixa antes de salvar' do
    subject.conteudo = 'AEI1'
    expect{subject.send(:downcase_conteudo)}.to change { subject.conteudo }.to('aei1')
  end
end
