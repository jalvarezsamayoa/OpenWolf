class AddFieldProfesionIdToSolicitudes < ActiveRecord::Migration
  def self.up
    add_column :solicitudes, :profesion_id, :integer
  end

  def self.down
    remove_column :solicitudes, :profesion_id
  end
end
