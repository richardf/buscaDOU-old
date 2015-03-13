class PrincipalController < ApplicationController
  after_action :clear_flash, only: [:create]

  def index
  end


  def create
    criado, termo = TermoCadastro.new(params.require(:email), params.require(:termo)).cadastrar

    if criado
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
