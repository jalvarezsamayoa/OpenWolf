class AddFieldsCodigoAbreviaturaToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :codigo, :string, :default => '9999-9999', :null => false
    add_column :instituciones, :abreviatura, :string, :default => 'NA', :null => false

    add_index :instituciones, :codigo
    add_index :instituciones, :abreviatura 
    
    
  end

  def self.down
    remove_column :instituciones, :abreviatura
    remove_column :instituciones, :codigo
    
    remove_index :instituciones, :codigo
    remove_index :instituciones, :abreviatura 
  end
end
