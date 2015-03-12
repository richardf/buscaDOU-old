class Termo < ActiveRecord::Base
  scope :ativo, -> { where(ativo: true) }

  validates :usuario, presence: true
  validates :conteudo, uniqueness: {:scope => :usuario}

  belongs_to :usuario

  alias_attribute :ativo?, :ativo
end
