class AddModuloIdToEstados < ActiveRecord::Migration
  def self.up
    add_column :estados, :modulo_id, :integer, :default => 1
    add_index :estados, :modulo_id
  end

  def self.down
    remove_column :estados, :modulo_id
  end
end
