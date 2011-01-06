class AddFieldAsignadaToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :asignada, :boolean
  end

  def self.down
    remove_column :solicitudes, :asignada
  end
end
