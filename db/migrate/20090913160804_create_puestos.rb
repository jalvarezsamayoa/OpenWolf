class CreatePuestos < ActiveRecord::Migration
  def self.up
    create_table :puestos do |t|
      t.string :nombre, :null => false                        
      t.integer :institucion_id, :null => false                                

      t.timestamps
    end

    add_index :puestos, :institucion_id
    
  end

  def self.down
    drop_table :puestos

    remove_index :puestos, :institucion_id 
    
  end
end
