require 'rails_helper'

RSpec.describe 'Ativacao', type: :feature do

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
    let!(:termo) { create(:termo_com_codigo) }
    let!(:visit_existente) { visit ativacao_path(termo.codigo) }

    it 'deve retornar status ok' do
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar mensagem de ativacao com sucesso' do
      expect(page).to have_content('O termo de pesquisa foi ativado com sucesso!')
    end
  end


  describe 'ao acessar o link de cancelamento com codigo existente' do
    let!(:termo) { create(:termo_com_codigo) }
    let!(:visit_existente) { visit cancelamento_path(termo.codigo) }

    it 'deve retornar status ok' do
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar mensagem de ativacao com sucesso' do
      expect(page).to have_content('O termo de pesquisa foi cancelado com sucesso!')
    end

  end


  describe 'ao acessar o link de cancelamento com codigo inexistente' do
    let!(:visit_inexistente) { visit cancelamento_path('foobar') }

    it 'deve retornar status ok' do
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar mensagem de erro' do
      expect(page).to have_content('O link de cancelamento informado é inválido.')
    end
  end
end