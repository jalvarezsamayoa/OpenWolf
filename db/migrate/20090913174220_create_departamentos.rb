class CreateDepartamentos < ActiveRecord::Migration
  def self.up
    create_table :departamentos do |t|
      t.string :nombre, :null => false
      t.string :abreviatura, :null => false                             
      t.timestamps
    end
  end

  def self.down
    drop_table :departamentos
  end
end
