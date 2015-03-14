require 'rails_helper'

RSpec.describe 'Principal', type: :feature do

  describe 'ao acessar link de validacao com codigo inexistente' do
    let!(:visit_inexistente) { visit ativacao_path('aaaa0000') }

    it 'deve retornar status ok' do
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar mensagem de erro' do
      expect(page).to have_content('O link de ativação informado é inválido.')
    end
  end


  describe 'ao acessar link de validacao com codigo existente' do
    let!(:ativacao) { create(:ativacao_com_termo, {codigo: 'foofoofoo'}) }
    let!(:visit_existente) { visit ativacao_path('foofoofoo') }

    it 'deve retornar status ok' do
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar mensagem de ativacao com sucesso' do
      expect(page).to have_content('O termo de pesquisa foi ativado com sucesso!')
    end
  end
end
