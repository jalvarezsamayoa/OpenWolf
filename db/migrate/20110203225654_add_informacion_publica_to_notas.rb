class AddInformacionPublicaToNotas < ActiveRecord::Migration
  def self.up
    add_column :notas, :informacion_publica, :boolean, :default => true, :null => false
    add_index :notas, :informacion_publica
  end

  def self.down
    remove_column :notas, :informacion_publica
  end
end
