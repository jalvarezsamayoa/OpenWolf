class AddFieldSolicitudIdToActividades < ActiveRecord::Migration
  def self.up
    add_column :actividades, :solicitud_id, :integer, :null => false
                                                      
    add_index :actividades, :solicitud_id     
  end

  def self.down
    remove_column :actividades, :solicitud_id

    remove_index :actividades, :solicitud_id     
  end
end
