require 'rails_helper'

RSpec.describe 'Principal', type: :feature do

  let!(:visit_root) { visit root_path }

  describe 'Ao visitar a pagina principal' do

    it 'deve retornar status ok' do
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar a pagina com o formulario de cadastro' do
      expect(page).to have_content('BuscaDOU')
      expect(page).to have_css("form input[name='termo']")
      expect(page).to have_css("form input[name='email']")
    end
  end


  describe 'Ao submeter o formulario de cadastro' do

    let(:t) { t = create(:termo_com_usuario) }

    it 'deve mostrar mensagem de sucesso ao submeter corretamente', :js => true do
      preencher_e_submeter_form 'Foobar', 'meu@email.com'
      expect(page).to have_content('Cadastrado com sucesso!')
    end

    it 'deve permitir cadastrar mesmo termo para usuario diferente', :js => true do
      preencher_e_submeter_form t.conteudo, 'outro@email.com'
      expect(page).to have_content('Cadastrado com sucesso!')
    end

    it 'deve avisar quando termo ja estiver cadastrado', :js => true do
      t = create(:termo_com_usuario, ativo: true)
      preencher_e_submeter_form t.conteudo, t.usuario.email
      expect(page).to have_content('O termo informado já está cadastrado e ativo.')
    end

    it 'deve permitir enviar novo email de confirmacao quando inativo', :js => true do
      preencher_e_submeter_form t.conteudo, t.usuario.email
      expect(page).to have_content('O termo informado já está cadastrado mas não foi ativado.')
    end

    it 'deve tratar caixa alta e baixa', :js => true do
      preencher_e_submeter_form t.conteudo.upcase, t.usuario.email.upcase
      expect(page).to have_content('O termo informado já está cadastrado mas não foi ativado.')
    end

  end
end

def preencher_e_submeter_form(termo, email)
  fill_in 'Termo', with: termo
  fill_in 'Email', with: email
  click_on 'Cadastrar termo'
end
