class AddFieldsTiempoRespuestaToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :tiempo_respuesta, :integer, :default => 0
    add_column :solicitudes, :tiempo_respuesta_calendario, :integer, :default => 0

    add_index :solicitudes, :tiempo_respuesta
    add_index :solicitudes, :tiempo_respuesta_calendario
  end

  def self.down
    remove_column :solicitudes, :tiempo_respuesta_calendario
    remove_column :solicitudes, :tiempo_respuesta
  end
end
