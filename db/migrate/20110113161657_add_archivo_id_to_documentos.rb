class AddArchivoIdToDocumentos < ActiveRecord::Migration
  def self.up
    add_column :documentos, :archivo_id, :integer
    add_index :documentos, :archivo_id
  end

  def self.down
    remove_column :documentos, :archivo_id
  end
end
