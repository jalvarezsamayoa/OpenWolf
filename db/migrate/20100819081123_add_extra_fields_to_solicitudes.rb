class AddExtraFieldsToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :genero_id, :integer
    add_column :solicitudes, :rangoedad_id, :integer
    add_column :solicitudes, :clasificacion_id, :integer
    add_column :solicitudes, :dias_respuesta, :integer
    add_column :solicitudes, :dias_prorroga, :integer
    add_column :solicitudes, :motivonegativa_id, :integer
    add_column :solicitudes, :motivoprorroga_id, :integer

    add_index :solicitudes, :genero_id
    add_index :solicitudes, :rangoedad_id
    add_index :solicitudes, :clasificacion_id
    add_index :solicitudes, :motivonegativa_id
    add_index :solicitudes, :motivoprorroga_id
  end

  def self.down
    remove_column :solicitudes, :motivoprorroga_id
    remove_column :solicitudes, :motivonegativa_id
    remove_column :solicitudes, :dias_prorroga
    remove_column :solicitudes, :dias_respuesta
    remove_column :solicitudes, :clasificacion_id
    remove_column :solicitudes, :rangoedad_id
    remove_column :solicitudes, :genero_id


    remove_index :solicitudes, :genero_id
    remove_index :solicitudes, :rangoedad_id
    remove_index :solicitudes, :clasificacion_id
    remove_index :solicitudes, :motivonegativa_id
    remove_index :solicitudes, :motivoprorroga_id
  end
end
