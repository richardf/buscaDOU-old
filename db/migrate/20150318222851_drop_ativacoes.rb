class DropAtivacoes < ActiveRecord::Migration
  def change
    drop_table :ativacoes
  end
end
