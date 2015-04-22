class TermoMailer < ApplicationMailer

  def termos_encontrados(usuario, ocorrencias)
    @email = usuario.email
    @ocorrencias = ocorrencias
    mail(to: @email, subject: 'BuscaDOU: Termos de busca encontrados!')
  end
end
