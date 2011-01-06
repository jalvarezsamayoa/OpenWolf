class CreateMunicipios < ActiveRecord::Migration
  def self.up
    create_table :municipios do |t|
      t.string :nombre, :null => false                        
      t.integer :departamento_id, :null => false                                  

      t.timestamps
    end

    add_index :municipios, :departamento_id    
  end

  def self.down
    drop_table :municipios

    remove_index :municipios, :departamento_id
  end
end
