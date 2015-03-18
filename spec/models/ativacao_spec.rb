require 'rails_helper'

RSpec.describe Ativacao, type: :model do

  it { is_expected.to respond_to(:ativo?) }


  describe 'ao criar um codigo de ativacao' do
    it 'deve gravar o codigo para o termo' do
      termo = build(:termo, {id: 1})
      expect(Ativacao).to receive(:create!).with(hash_including(:codigo, :termo))
      Ativacao.criar_codigo(termo)
    end

    it 'deve enviar um email de ativacao' do
      termo = create(:termo_com_usuario)
      expect{Ativacao.criar_codigo(termo)}.to change {ActionMailer::Base.deliveries.size}.by 1
    end
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
