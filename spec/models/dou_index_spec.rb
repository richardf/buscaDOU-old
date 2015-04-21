require 'rails_helper'

RSpec.describe DOUIndex, type: :model do
  subject{build(:DOUIndex)}

  it { is_expected.to respond_to(:conteudo) }
  it { is_expected.to respond_to(:data) }
  it { is_expected.to respond_to(:pagina) }
  it { is_expected.to respond_to(:secao) }

  it 'eh invalido sem conteudo' do
    subject.conteudo = nil
    expect(subject.valid?).to be false
  end

  it 'eh invalido sem data' do
    subject.data = nil
    expect(subject.valid?).to be false
  end

  it 'eh invalido sem pagina' do
    subject.pagina = nil
    expect(subject.valid?).to be false
  end

  it 'eh invalido sem secao' do
    subject.secao = nil
    expect(subject.valid?).to be false
  end

  it 'eh valido com todos os campos preenchidos' do
    expect(subject.valid?).to be true
  end
end