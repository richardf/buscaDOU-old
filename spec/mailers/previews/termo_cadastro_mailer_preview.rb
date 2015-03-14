# Preview all emails at http://localhost:3000/rails/mailers/termo_cadastro_mailer
class TermoCadastroMailerPreview < ActionMailer::Preview
  def termo_cadastro
    TermoCadastroMailer.ativar_termo_email('foo@bar.com', 'foobar', '0xdeadbeef')
  end
end
