# Preview all emails at http://localhost:3000/rails/mailers/termo_mailer
class TermoMailerPreview < ActionMailer::Preview
  def termo_cadastro
  	usuario = Usuario.new
  	usuario.email = 'foo@bar.com'

  	ocorr1 = {data: Date.today, pagina: 12, secao: 3, destaque: 'O <em>termo</em> pesquisado está nesta frase.'}
  	ocorrencias = [ocorr1]
    TermoMailer.termos_encontrados(usuario, ocorrencias)
  end
end
