class AgregarCamposToUsuarios < ActiveRecord::Migration
  def self.up
    
    add_column :usuarios, :genero, :boolean, :default => false
    add_column :usuarios, :fecha_nacimiento, :date
    add_column :usuarios, :direccion, :string, :default => "No Disponible", :null => false
    add_column :usuarios, :telefonos, :string, :default => "No Disponible",  :null => false
    

    remove_column :usuarios, :departamento_id
    remove_column :usuarios, :areadocumento_id
    remove_column :essupervisorarea
            
  end

  def self.down
    
    remove_column :usuarios, :genero
    remove_column :usuarios, :fecha_nacimiento
    remove_column :usuarios, :direccion
    remove_column :usuarios, :telefonos
    
    
    
    
  end
end
