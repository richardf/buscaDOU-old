class AtivacaoController < ApplicationController

  def show
    cod_ativacao = params.require(:codigo)
    ativacao = Ativacao.find_by(codigo: cod_ativacao)

    if ativacao
      ativacao.ativar! unless ativacao.ativo?
      flash[:destaque] = 'O termo de pesquisa foi ativado com sucesso!'
      flash[:mensagem] = 'Você será notificado(a) quando o termo cadastrado for citado no D.O.U.'
    else
      flash[:destaque] = 'O link de ativação informado é inválido.'
      flash[:mensagem] = 'Por favor verifique se o link está correto. Em caso de dúvidas, entre em contato.'
    end
  end
end
