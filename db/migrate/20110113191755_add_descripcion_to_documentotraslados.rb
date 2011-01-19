class AddDescripcionToDocumentotraslados < ActiveRecord::Migration
  def self.up
    add_column :documentotraslados, :descripcion, :text
  end

  def self.down
    remove_column :documentotraslados, :descripcion
  end
end
