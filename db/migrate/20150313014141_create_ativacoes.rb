class CreateAtivacoes < ActiveRecord::Migration
  def change
    create_table :ativacoes do |t|
      t.string :codigo, null: false
      t.references :termo, index: true
      t.datetime :ativado_at

      t.timestamps null: false
    end
    add_index :ativacoes, :codigo
    add_foreign_key :ativacoes, :termos
  end
end
