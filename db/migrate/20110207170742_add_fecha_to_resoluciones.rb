class AddFechaToResoluciones < ActiveRecord::Migration
  def self.up
    add_column :resoluciones, :fecha, :date
    add_index :resoluciones, :fecha
  end

  def self.down
    remove_column :resoluciones, :fecha
  end
end
