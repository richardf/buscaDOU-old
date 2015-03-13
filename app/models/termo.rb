class Termo < ActiveRecord::Base
  scope :ativos, -> { where(ativo: true) }

  validates :usuario, presence: true
  validates :conteudo, uniqueness: {:scope => :usuario}, presence: true

  belongs_to :usuario

  alias_attribute :ativo?, :ativo

  before_create :downcase_conteudo

  def ativar!
    self.ativo = true
    save
  end

  protected
  def downcase_conteudo
    conteudo.downcase!
  end
end
