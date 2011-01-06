class CreateAdjuntos < ActiveRecord::Migration
  def self.up
    create_table :adjuntos do |t|
      t.string :numero, :null => false                        
      t.text :observaciones
      t.integer :usuario_id, :null => false                             
      t.integer :proceso_id, :null => false                             
      t.string :proceso_type, :null => false                              

      t.timestamps
    end

    add_index :adjuntos, :numero
    add_index :adjuntos, :usuario_id
    add_index :adjuntos, :proceso_id 
    add_index :adjuntos, :proceso_type 
        
  end

  def self.down
    drop_table :adjuntos

    drop_index :adjuntos, :numero
    drop_index :adjuntos, :usuario_id
    drop_index :adjuntos, :proceso_id 
    drop_index :adjuntos, :proceso_type  
  end
end
