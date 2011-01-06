class AddFieldFinalToEstados < ActiveRecord::Migration
  def self.up
    add_column :estados, :final, :boolean, :default => false
    add_column :estados, :puede_entregar, :boolean, :default => false

    add_index :estados, :final
    add_index :estados, :puede_entregar
    
  end

  def self.down
    remove_column :estados, :final
    remove_column :estados, :puede_entregar

    remove_index :estados, :final 
    
  end
end
