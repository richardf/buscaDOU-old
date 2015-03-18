class TermoCadastro
  def initialize(email, termo_cadastro)
    @email = email.downcase
    @termo_cadastro = termo_cadastro.downcase
  end

  def cadastrar
    Usuario.transaction do
      usuario = Usuario.find_or_create_by!(email: @email)
      termo = Termo.find_by(conteudo: @termo_cadastro, usuario: usuario)
      criado = false

      if termo.nil?
        termo = Termo.create!(conteudo: @termo_cadastro, usuario: usuario)
        criado = true
      end

      return criado, termo
    end
  end
end
