require 'rails_helper'

RSpec.describe Termo, type: :model do
  it { is_expected.to respond_to(:ativo?) }

  describe 'ao ser criado' do
    it { is_expected.not_to be_valid }

    it 'deve estar inativo' do
      expect(subject.ativo?).to be false
    end
  end
end
