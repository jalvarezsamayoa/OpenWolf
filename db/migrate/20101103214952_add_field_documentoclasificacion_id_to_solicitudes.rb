class AddFieldDocumentoclasificacionIdToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :documentoclasificacion_id, :integer, :default => 1
    add_index :solicitudes, :documentoclasificacion_id
  end

  def self.down
    remove_column :solicitudes, :documentoclasificacion_id
  end
end
