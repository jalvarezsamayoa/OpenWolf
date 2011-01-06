class AddPublicaToSolicitud < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :informacion_publica, :boolean, :null => false, :default => true
    add_column :seguimientos, :informacion_publica, :boolean, :null => false, :default => true
    add_column :razonestiposresoluciones, :informacion_publica, :boolean, :null => false, :default => true
    add_column :adjuntos, :informacion_publica, :boolean, :null => false, :default => true
    add_column :resoluciones, :informacion_publica, :boolean, :null => false, :default => true
    
    add_index :solicitudes, :informacion_publica
    add_index :seguimientos, :informacion_publica
    add_index :razonestiposresoluciones, :informacion_publica
    add_index :adjuntos, :informacion_publica
    add_index :resoluciones, :informacion_publica
    
  end

  def self.down
    remove_column :solicitudes, :informacion_publica
    remove_column :seguimientos, :informacion_publica
    remove_column :razonestiposresoluciones, :informacion_publica
    remove_column :adjuntos, :informacion_publica
    remove_column :resoluciones, :informacion_publica
  end
end
