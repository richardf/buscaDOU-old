class Ativacao < ActiveRecord::Base
  validates :termo, presence: true
  validates :codigo, presence: true

  belongs_to :termo

  after_create :email_ativacao

  def self.criar_codigo(termo)
    self.create!(codigo: SecureRandom.hex, termo: termo)
  end

  def ativar!
    self.transaction do
      self.ativado_at = DateTime.current
      self.termo.ativar!
      save!
    end
  end

  def ativo?
    self.ativado_at != nil
  end

  def email_ativacao
    TermoCadastroMailer.ativar_termo_email(termo.usuario.email, termo.conteudo, codigo).deliver_later
  end
end
