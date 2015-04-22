require "rails_helper"

RSpec.describe TermoMailer, type: :mailer do

	subject { TermoMailer }

	describe 'ao enviar o email de notificacao de termo encontrado' do
		let!(:usuario) {build(:usuario)}
		let!(:ocorrencias) {[{data: Date.today, pagina: 12, secao: 3, destaque: 'O termo pesquisado esta nesta frase.'}]}
		let!(:email) { email = subject.termos_encontrados(usuario, ocorrencias).deliver_now }

		it 'deve adicionar o email na fila de envios' do
			expect(ActionMailer::Base.deliveries.empty?).not_to be true
		end

		it 'deve utilizar os dados corretos no email' do
			expect(email.to.size).to eq 1
			expect(email.to.first).to eq(usuario.email)
			expect(email.subject).to eq 'BuscaDOU: Termos de busca encontrados!'
		end

		it 'deve incluir o destaque, pagina e secao no corpo do email' do
			expect(email.text_part.body.encoded).to include 'O termo pesquisado esta nesta frase.'
			expect(email.text_part.body.encoded).to include 'Página: 12'
			expect(email.text_part.body.encoded).to include 'Seção: 3'
		end
	end
end
