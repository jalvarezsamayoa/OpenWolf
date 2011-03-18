class AddFieldFechaToFeriados < ActiveRecord::Migration
  def self.up
    add_column :feriados, :fecha, :date
    add_index :feriados, :fecha
  end

  def self.down
    remove_column :feriados, :fecha
  end
end
