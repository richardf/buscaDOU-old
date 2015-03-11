class PrincipalController < ApplicationController
  around_action :create_transaction, only: :create
  after_action :clear_flash, only: [:create]

  def index
  end


  def create
    termo_cadastro = params.require(:termo).downcase
    usuario = Usuario.find_or_create_by!(email: params.require(:email).downcase)
    termo = Termo.find_by(conteudo: termo_cadastro, usuario: usuario)

    if termo.nil?
      Termo.create!(conteudo: termo_cadastro, usuario: usuario)
      flash[:notice] = 'Cadastrado com sucesso! :-)'
    else
      if termo.ativo?
        flash[:error] = 'O termo informado já está cadastrado e ativo.'
      else
        flash[:error] = 'O termo informado já está cadastrado mas não foi ativado. Reenviar email de ativação.'
      end
    end

    respond_to { |format| format.js }
  end
end
