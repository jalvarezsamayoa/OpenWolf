class CreateDocumentodestinatarios < ActiveRecord::Migration
  def self.up
    create_table :documentodestinatarios do |t|
      t.integer :documento_id, :null => false
      t.integer :copia_id
      t.integer :usuario_id, :null => false
      t.boolean :original, :null => false
      t.integer :documentoestado_id, :null => false, :default => 1 #1 NoEntregado
      t.integer :institucion_id, :null => false
      t.string :puesto
      t.string :departamento

      t.timestampsy
    end

    add_index :documentodestinatarios, :documento_id
    add_index :documentodestinatarios, :copia_id
    add_index :documentodestinatarios, :usuario_id
    add_index :documentodestinatarios, :original
    add_index :documentodestinatarios, :documentoestado_id
    add_index :documentodestinatarios, :institucion_id
    
  end

  def self.down
    drop_table :documentodestinatarios
  end
end
