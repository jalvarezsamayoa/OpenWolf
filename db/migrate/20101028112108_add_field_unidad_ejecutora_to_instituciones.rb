class AddFieldUnidadEjecutoraToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :unidad_ejecutora, :string
    add_column :instituciones, :entidad, :string

    add_index :instituciones, :unidad_ejecutora
    add_index :instituciones, :entidad
  end

  def self.down
    remove_column :instituciones, :entidad
    remove_column :instituciones, :unidad_ejecutora
  end
end
