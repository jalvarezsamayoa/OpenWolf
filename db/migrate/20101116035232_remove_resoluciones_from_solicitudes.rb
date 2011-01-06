class RemoveResolucionesFromSolicitudes < ActiveRecord::Migration
  def self.up
    remove_column :solicitudes, :resoluciones
  end

  def self.down
  end
end
