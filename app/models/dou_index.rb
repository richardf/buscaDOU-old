require 'elasticsearch/persistence/model'

class DOUIndex
	include Elasticsearch::Persistence::Model

	attribute :conteudo,  String
	attribute :pagina,  Integer
	attribute :secao,  Integer
	attribute :data,  Date

	validates :conteudo, presence: true
	validates :pagina, presence: true
	validates :secao, presence: true
	validates :data, presence: true
end