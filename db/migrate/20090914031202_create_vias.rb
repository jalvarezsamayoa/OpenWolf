class CreateVias < ActiveRecord::Migration
  def self.up
    create_table :vias do |t|
      t.string :nombre, :null => false
                        
      t.timestamps
    end
  end

  def self.down
    drop_table :vias
  end
end
