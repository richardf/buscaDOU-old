require "rails_helper"

RSpec.describe TermoCadastroMailer, type: :mailer do
  let(:subject) { TermoCadastroMailer }

  describe 'ao enviar o email de confirmacao de cadastro' do
    let!(:email) { email = subject.ativar_termo_email('foo@bar.com', 'o termo', 'XXXXXX').deliver_now }

    it 'deve adicionar o email na fila de envios' do
      expect(ActionMailer::Base.deliveries.empty?).not_to be true
    end

    it 'deve utilizar os dados corretos no email' do
      expect(email.to.size).to eq 1
      expect(email.to.first).to eq 'foo@bar.com'
      expect(email.subject).to eq 'BuscaDOU: Ative o termo de busca'
    end

    it 'deve incluir o link de confirmacao no email' do
      expect(email.body.encoded).to include 'http://buscadou.com/ativar/XXXXXX'
    end
  end
end
