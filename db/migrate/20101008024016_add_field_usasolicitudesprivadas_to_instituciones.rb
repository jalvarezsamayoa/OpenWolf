class AddFieldUsasolicitudesprivadasToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :usasolicitudesprivadas, :boolean, :default => false
  end

  def self.down
    remove_column :instituciones, :usasolicitudesprivadas
  end
end
