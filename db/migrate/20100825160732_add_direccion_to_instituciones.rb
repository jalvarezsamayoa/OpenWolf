class AddDireccionToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :direccion, :string
    add_column :instituciones, :telefono, :string
  end

  def self.down
    remove_column :instituciones, :telefono
    remove_column :instituciones, :direccion
  end
end
