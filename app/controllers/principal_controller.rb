class PrincipalController < ApplicationController
  around_action :create_transaction, only: :create

  def index
  end


  def create
      termo_cadastro = params.require(:termo)
      usuario = Usuario.find_or_create_by!(email: params.require(:email))
      termo = Termo.find_by(conteudo: termo_cadastro)

      if termo.nil?
        Termo.create!(conteudo: termo_cadastro, usuario: usuario)
        flash[:notice] = "Cadastrado com sucesso!"
      elsif
        flash[:error] = "Erro... :("
      end

    respond_to { |format| format.js }
  end
end
