class AddPositivaToTiporesoluciones < ActiveRecord::Migration
  def self.up
    add_column :tiposresoluciones, :positiva, :boolean, :default => false
    add_column :tiposresoluciones, :aliaspdh, :string

    add_index :tiposresoluciones, :positiva
  end

  def self.down
    remove_column :tiposresoluciones, :aliaspdh
    remove_column :tiposresoluciones, :positiva
  end
end
