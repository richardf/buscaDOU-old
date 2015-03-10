class CreateTermos < ActiveRecord::Migration
  def change
    create_table :termos do |t|
      t.string :conteudo, null: false
      t.boolean :ativo, default: false
      t.references :usuario, index: true

      t.timestamps null: false
    end
    add_index :termos, :ativo
    add_foreign_key :termos, :usuarios
  end
end
