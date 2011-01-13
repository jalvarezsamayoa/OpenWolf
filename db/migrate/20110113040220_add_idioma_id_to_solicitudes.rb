class AddIdiomaIdToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :idioma_id, :integer, :null => false, :default => 12
    add_index :solicitudes, :idioma_id
  end

  def self.down
    remove_column :solicitudes, :idioma_id
  end
end
