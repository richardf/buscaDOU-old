class Usuario < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /@/, on: :create }

  has_many :termos

  alias_attribute :ativo?, :ativo

  before_create :downcase_email

  protected
  def downcase_email
    email.downcase!
  end
end
