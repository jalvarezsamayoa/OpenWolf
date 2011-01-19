class CreateDocumentotraslados < ActiveRecord::Migration
  def self.up
    create_table :documentotraslados do |t|
      t.integer :institucion_id, :null => false
      t.integer :usuario_id, :null => false
      t.integer :destinatario_id, :null => false
      t.integer :documento_id, :null => false
      t.integer :documento_destinatario_id, :null => false
      t.boolean :original, :default => false
      t.integer :estado_entrega_id, :default => 1, :null => false
      t.datetime :fecha_envio
      t.datetime :fecha_respuesta

      t.timestamps
    end

    add_index :documentotraslados, :institucion_id
    add_index :documentotraslados, :usuario_id
    add_index :documentotraslados, :destinatario_id
    add_index :documentotraslados, :documento_id
    add_index :documentotraslados, :documento_destinatario_id
    add_index :documentotraslados, :original
    add_index :documentotraslados, :estado_entrega_id
    add_index :documentotraslados, :fecha_envio
    add_index :documentotraslados, :fecha_respuesta
    
  end

  def self.down
    drop_table :documentotraslados
  end
end
