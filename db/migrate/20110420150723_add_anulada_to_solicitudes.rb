class AddAnuladaToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :anulada, :boolean, :default => false
    add_index :solicitudes, :anulada
  end

  def self.down
    remove_column :solicitudes, :anulada
  end
end
