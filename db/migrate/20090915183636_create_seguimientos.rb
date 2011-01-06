class CreateSeguimientos < ActiveRecord::Migration
  def self.up
    create_table :seguimientos do |t|
      t.integer :actividad_id, :null => false                               
      t.integer :institucion_id, :null => false
      t.integer :usuario_id, :null => false
      t.date :fecha_creacion, :null => false
      t.text :textoseguimiento, :null => false

      t.timestamps
    end

    add_index :seguimientos, :actividad_id 
    add_index :seguimientos, :institucion_id
    add_index :seguimientos, :usuario_id
    add_index :seguimientos, :fecha_creacion
    
  end

  def self.down
    drop_table :seguimientos

    remove_index :seguimientos, :actividad_id 
    remove_index :seguimientos, :institucion_id
    remove_index :seguimientos, :usuario_id
    remove_index :seguimientos, :fecha_creacion
  end
end
