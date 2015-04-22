require 'elasticsearch/persistence/model'

class DOUIndex
	include Elasticsearch::Persistence::Model
	index_name [Rails.env, model_name.collection.gsub(/\//, '-')].join('_')

	attribute :conteudo,  String
	attribute :pagina,  Integer
	attribute :secao,  Integer
	attribute :data,  Date

	validates :conteudo, presence: true
	validates :pagina, presence: true
	validates :secao, presence: true
	validates :data, presence: true

	def self.procurar_por(termo, data)
		ret = self.search query: { match_phrase: {conteudo: termo}},
			filter: {term: { data: data }},
			highlight: { fields: { conteudo: {} } },
			fields: ['data', 'pagina', 'secao']

		ret.response.hits
	end
end