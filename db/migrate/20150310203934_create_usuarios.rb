class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :email, null: false
      t.boolean :ativo, default: true

      t.timestamps null: false
    end
    add_index :usuarios, :email
    add_index :usuarios, :ativo
  end
end
