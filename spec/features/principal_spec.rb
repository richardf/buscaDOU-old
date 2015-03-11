require 'rails_helper'

RSpec.describe 'Principal', type: :feature do

  describe 'Ao visitar a pagina principal' do

    it 'deve retornar status ok' do
      visit root_path
      expect(page).to have_http_status(200)
    end

    it 'deve mostrar a pagina com o formulario de cadastro' do
      visit root_path
      expect(page).to have_content('BuscaDOU')
      expect(page).to have_css("form input[name='termo']")
      expect(page).to have_css("form input[name='email']")
    end
  end
end
