class AtivacaoController < ApplicationController

  before_action :get_termo

  def ativar
    if @termo
      @termo.ativar! unless @termo.ativo?
      flash[:destaque] = 'O termo de pesquisa foi ativado com sucesso!'
      flash[:mensagem] = 'Você será notificado(a) quando o termo cadastrado for citado no D.O.U.'
    else
      flash[:destaque] = 'O link de ativação informado é inválido.'
      flash[:mensagem] = 'Por favor verifique se o link está correto. Em caso de dúvidas, entre em contato.'
    end
  end

  def cancelar
    if @termo
      @termo.desativar! if @termo.ativo?
      flash[:destaque] = 'O termo de pesquisa foi cancelado com sucesso!'
      flash[:mensagem] = 'Você não será mais notificado(a) quando o termo cadastrado for citado no D.O.U.'
    else
      flash[:destaque] = 'O link de cancelamento informado é inválido.'
      flash[:mensagem] = 'Por favor verifique se o link está correto. Em caso de dúvidas, entre em contato.'
    end

    render 'ativar'
  end

  protected
  def get_termo
    codigo_termo = params.require(:codigo)
    @termo = Termo.find_by(codigo: codigo_termo)
  end
end
