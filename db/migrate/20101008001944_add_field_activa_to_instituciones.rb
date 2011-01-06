class AddFieldActivaToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :activa, :boolean, :default => false
    add_index :instituciones, :activa
  end

  def self.down
    remove_column :instituciones, :activa
  end
end
