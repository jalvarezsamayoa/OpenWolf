class CreateDocumentoclasificaciones < ActiveRecord::Migration
  def self.up
    create_table :documentoclasificaciones do |t|
      t.string :nombre
      t.integer :documentocategoria_id
      t.string :codigo
      t.string :plantilla
      
      t.timestamps
    end

    add_index :documentoclasificaciones, :documentocategoria_id
    add_index :documentoclasificaciones, :codigo
  end

  def self.down
    drop_table :documentoclasificaciones
  end
end
