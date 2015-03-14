class TermoCadastroMailer < ApplicationMailer

  def ativar_termo_email(email, termo, codigo_ativacao)
    @email = email
    @codigo  = codigo_ativacao
    @termo  = termo
    mail(to: @email, subject: 'BuscaDOU: Ative o termo de busca')
  end
end
