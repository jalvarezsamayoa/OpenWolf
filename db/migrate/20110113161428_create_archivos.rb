class CreateArchivos < ActiveRecord::Migration
  def self.up
    create_table :archivos do |t|
      t.string :nombre, :null => false
      t.integer :institucion_id, :null => false

      t.timestamps
    end

    add_index :archivos, :institucion_id
    
  end

  def self.down
    drop_table :archivos
  end
end
