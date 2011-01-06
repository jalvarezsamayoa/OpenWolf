class AddFieldDocumentoclasificacionIdToResoluciones < ActiveRecord::Migration
  def self.up
    add_column :resoluciones, :documentoclasificacion_id, :integer, :default => 2
    add_index :resoluciones, :documentoclasificacion_id
  end

  def self.down
    remove_column :resoluciones, :documentoclasificacion_id
  end
end
