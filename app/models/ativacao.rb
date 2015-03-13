class Ativacao < ActiveRecord::Base
  validates :termo, presence: true
  validates :codigo, presence: true

  belongs_to :termo

  def self.criar_codigo
    SecureRandom.hex
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
