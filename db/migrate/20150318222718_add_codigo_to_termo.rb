class AddCodigoToTermo < ActiveRecord::Migration
  def change
    add_column :termos, :codigo, :string
    change_column :termos, :codigo, :string, :null => false
    add_index :termos, :codigo
  end
end
