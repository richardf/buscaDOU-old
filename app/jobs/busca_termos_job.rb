class BuscaTermosJob < ActiveJob::Base
  queue_as :default
  after_perform :notifica_usuario

  # rescue_from(StandardError) do |exception|
  # end

  def perform(usuario_id, data)
  	@termos = Termo.includes(:usuario).where(usuario_id: usuario_id).ativos
  	@ocorrencias = []
  	@termos.each do |termo|
  		res = DOUIndex.procurar_por(termo.conteudo, data)  		
  		if res.total
  			processa_resultado(res)
  		end
  	end
  end

  private
  def processa_resultado(res)
		res.hits.each do |ocorrencia|
			@ocorrencias << processa(ocorrencia)
		end
  end

  def processa(ocorrencia)
  	ret = {}
  	if ocorrencia.fields.data
	  	data = ocorrencia.fields.data.first.split('-')
	  	data = "#{data[2]}/#{data[1]}/#{data[0]}"
	  	ret[:data] = ocorrencia.fields.data.first
  	end
  	ret[:pagina] = ocorrencia.fields.pagina
  	ret[:secao] = ocorrencia.fields.secao
  	ret[:destaque] = ocorrencia.highlight
  	ret
  end

  def notifica_usuario
  	unless @ocorrencias.empty?
  		TermoMailer.termos_encontrados(@termos.first.usuario, @ocorrencias).deliver_later
  	end
  end
end