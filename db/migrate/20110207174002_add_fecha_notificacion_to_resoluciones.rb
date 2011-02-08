class AddFechaNotificacionToResoluciones < ActiveRecord::Migration
  def self.up
    add_column :resoluciones, :fecha_notificacion, :date
    add_index :resoluciones, :fecha_notificacion
  end

  def self.down
    remove_column :resoluciones, :fecha_notificacion
  end
end
