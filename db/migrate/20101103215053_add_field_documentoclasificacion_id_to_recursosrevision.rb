class AddFieldDocumentoclasificacionIdToRecursosrevision < ActiveRecord::Migration
  def self.up
    add_column :recursosrevision, :documentoclasificacion_id, :integer, :default => 3
    add_index :recursosrevision, :documentoclasificacion_id
  end

  def self.down
    remove_column :recursosrevision, :documentoclasificacion_id
  end
end
