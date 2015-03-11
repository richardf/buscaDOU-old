class Termo < ActiveRecord::Base
  validates :usuario, presence: true

  belongs_to :usuario
end
