class AddActualizaFechaNotificacionToTiposresoluciones < ActiveRecord::Migration
  def self.up
    add_column :tiposresoluciones, :actualiza_fecha_notificacion, :boolean, :default => false
  end

  def self.down
    remove_column :tiposresoluciones, :actualiza_fecha_notificacion
  end
end
