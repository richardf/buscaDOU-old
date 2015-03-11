class Usuario < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /@/, on: :create }

  has_many :termos

  def ativo?
    ativo
  end
end
