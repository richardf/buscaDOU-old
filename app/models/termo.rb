class Termo < ActiveRecord::Base
  scope :ativos, -> { where(ativo: true) }

  validates :usuario, presence: true
  validates :conteudo, uniqueness: {:scope => :usuario}, presence: true, length: { in: 4..100 }

  belongs_to :usuario

  alias_attribute :ativo?, :ativo

  before_create :downcase_conteudo, :codigo_ativacao
  after_create :email_ativacao


  def ativar!
    self.ativo = true
    save!
  end

  protected
  def downcase_conteudo
    conteudo.downcase!
  end

  def codigo_ativacao
    self.codigo = SecureRandom.hex
  end

  def email_ativacao
    TermoCadastroMailer.ativar_termo_email(usuario.email, conteudo, codigo).deliver_later
  end
end
