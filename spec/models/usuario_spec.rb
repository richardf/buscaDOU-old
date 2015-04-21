require 'rails_helper'

RSpec.describe Usuario, type: :model do

  it { is_expected.to respond_to(:ativo?) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:termos) }

  describe 'ao ser criado' do
    it { is_expected.not_to be_valid }

    it 'deve estar ativo' do
      expect(subject.ativo?).to be true
    end
  end

  it 'deve ser invalido com email invalido' do
    subject.email = 'email_invalido.com'
    expect(subject.valid?).to be false
  end

  it 'deve ser valido com email valido' do
    subject.email = 'email@valido.com'
    expect(subject.valid?).to be true
  end

  it 'deve converter o email para caixa baixa antes de salvar' do
    subject.email = 'MEU@EMAIL.COM'
    expect{subject.send(:downcase_email)}.to change { subject.email }.to('meu@email.com')
  end
end
