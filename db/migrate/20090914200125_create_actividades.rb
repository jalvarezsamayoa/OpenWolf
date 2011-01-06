class CreateActividades < ActiveRecord::Migration
  def self.up
    create_table :actividades do |t|
      t.integer :institucion_id, :null => false                                 
      t.integer :usuario_id, :null => false
      t.date :fecha_asignacion, :null => false
      t.text :textoactividad, :null => false
      t.integer :estado_id, :null => false, :default => 1
      t.date :fecha_resolucion

      t.timestamps
    end

    add_index :actividades, :institucion_id
    add_index :actividades, :usuario_id
    add_index :actividades, :fecha_asignacion
    add_index :actividades, :estado_id
    add_index :actividades, :fecha_resolucion
    
  end

  def self.down
    drop_table :actividades

    remove_index :actividades, :institucion_id
    remove_index :actividades, :usuario_id
    remove_index :actividades, :fecha_asignacion
    remove_index :actividades, :estado_id
    remove_index :actividades, :fecha_resolucion
  end
end
