class AddFieldNumeroToRecursosrevision < ActiveRecord::Migration
  def self.up
    add_column :recursosrevision, :numero, :string, :nil => false
    add_index :recursosrevision, :numero
  end

  def self.down
    remove_column :recursosrevision, :numero
  end
end
