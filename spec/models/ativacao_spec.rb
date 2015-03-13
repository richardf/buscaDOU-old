require 'rails_helper'

RSpec.describe Ativacao, type: :model do

  it { is_expected.to respond_to(:ativo?) }

  it 'deve criar um codigo aleatorio para cada ativacao' do
    expect(Ativacao.criar_codigo).to be_a_kind_of String
    expect(Ativacao.criar_codigo.size).to be > 16
  end

  it 'nao deve ser valido sem o codigo' do
    subject.termo = build(:termo)
    expect(subject.valid?).to be false
  end

  it 'nao deve ser valido sem o termo' do
    subject.codigo = 'AAAA0000'
    expect(subject.valid?).to be false
  end


  describe 'ao ser criado' do
    it { is_expected.not_to be_valid }

    it 'nao deve estar ativado' do
      expect(subject.ativo?).to be false
    end
  end


  describe 'ao ativar' do
    let(:subject) {build(:ativacao)}

    it 'deve preencher a data de ativacao' do
      allow(subject).to receive(:save!).and_return(true)
      allow(subject.termo).to receive(:save!).and_return(true)
      subject.ativar!
      expect(subject.ativado_at).to_not be_nil
    end

    it 'deve indicar que esta ativo' do
      allow(subject).to receive(:save!).and_return(true)
      allow(subject.termo).to receive(:save!).and_return(true)
      expect{subject.ativar!}.to change { subject.ativo? }.from(false).to(true)
    end

    it 'deve ativar o termo' do
      allow(subject).to receive(:save!).and_return(true)
      allow(subject.termo).to receive(:save!).and_return(true)
      expect(subject.termo).to receive(:ativo=)
      subject.ativar!
    end
  end
end
