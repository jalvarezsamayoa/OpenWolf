class AddFieldOrigenIdToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :origen_id, :integer, :default => 1
    add_index :solicitudes, :origen_id
  end

  def self.down
    remove_column :solicitudes, :origen_id
  end
end
