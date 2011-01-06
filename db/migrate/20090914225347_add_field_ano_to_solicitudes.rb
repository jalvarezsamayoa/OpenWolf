class AddFieldAnoToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :ano, :integer, :null => false                                             
    add_column :solicitudes, :numero, :integer, :null => false
    
    add_index :solicitudes, :ano
    add_index :solicitudes, :numero 
        
  end

  def self.down
    remove_column :solicitudes, :numero
    remove_column :solicitudes, :ano

    remove_index :solicitudes, :ano
    remove_index :solicitudes, :numero 
  end
end
