class CreateResoluciones < ActiveRecord::Migration
  def self.up
    create_table :resoluciones do |t|
      t.string :numero, :null => false
      t.integer :solicitud_id, :null => false
      t.integer :usuario_id, :null => false
      t.integer :institucion_id, :null => false
      t.text :descripcion, :null => false
      t.integer :tiporesolucion_id, :null => false
      t.integer :razontiporesolucion_id, :null => false
      t.date :nueva_fecha

      t.timestamps
    end

    add_index :resoluciones, :numero
    add_index :resoluciones, :solicitud_id
    add_index :resoluciones, :usuario_id
    add_index :resoluciones, :institucion_id
    add_index :resoluciones, :tiporesolucion_id
    add_index :resoluciones, :razontiporesolucion_id
  end

  def self.down
    drop_table :resoluciones
  end
end
