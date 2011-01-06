class AddResolucionesToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :resoluciones, :string
  end

  def self.down
    remove_column :solicitudes, :resoluciones
  end
end
