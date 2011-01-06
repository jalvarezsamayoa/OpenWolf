class AddFieldTextoToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :textosolicitud, :text
  end

  def self.down
    remove_column :solicitudes, :textosolicitud
  end
end
