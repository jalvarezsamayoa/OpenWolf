class AddReservaTemporalToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :reserva_temporal, :boolean, :default => false
    add_index :solicitudes, :reserva_temporal

    Solicitud.update_all(:reserva_temporal => false)
  end

  def self.down
    remove_column :solicitudes, :reserva_temporal
  end
end
