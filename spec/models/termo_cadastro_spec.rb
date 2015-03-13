require 'rails_helper'

RSpec.describe TermoCadastro, type: :model do

    let(:subject) { TermoCadastro.new('um@EMAIL.com', 'FooBar') }
    let!(:termo_find) { allow(Termo).to receive(:find_by).and_return(build(:termo)) }
    let!(:termo_create) { allow(Termo).to receive(:create!).and_return(build(:termo)) }
    let!(:usuario_find) { allow(Usuario).to receive(:find_or_create_by!).and_return(build(:usuario)) }

    describe 'ao registrar' do

      it 'deve procurar o usuario pelo email desconsiderando caixa alta e baixa' do
        expect(Usuario).to receive(:find_or_create_by!).with(hash_including(:email => 'um@email.com'))
        subject.cadastrar

      end

      it 'deve procurar o termo pelo conteudo desconsiderando caixa alta e baixa' do
        expect(Termo).to receive(:find_by).with(hash_including(:conteudo => 'foobar'))
        subject.cadastrar
      end

      it 'deve retornar verdadeiro e o termo se o termo nao existir' do
        allow(Termo).to receive(:find_by).and_return(nil)
        criado, termo = subject.cadastrar
        expect(criado).to be true
        expect(termo).to_not be_nil
      end

      it 'deve retornar falso e o termo se o termo existir' do
        criado, termo = subject.cadastrar
        expect(criado).to be false
        expect(termo).to_not be_nil
      end
    end
end