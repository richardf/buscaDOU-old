class Ativacao < ActiveRecord::Base
  validates :termo, presence: true
  validates :codigo, presence: true

  belongs_to :termo

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
end
