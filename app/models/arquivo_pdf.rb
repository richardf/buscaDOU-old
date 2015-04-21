class ArquivoPDF

	attr_reader :texto

	def initialize(nome_arquivo)
		begin
			@arquivo = PDF::Toolkit.open(nome_arquivo)
			@texto = @arquivo.to_text.read
			@texto = remove_caracteres_controle()
		rescue => e
			raise IOError.new(e)
		end
	end

	def numero_paginas
		@arquivo.page_count
	end


	private
	def remove_caracteres_controle()
		@texto.chars.inject('') do |str, char|
			if char.ascii_only? and (char.ord < 32 or char.ord == 127)
				str << ' '
			else
				str << char
			end
			str
		end
	end
end