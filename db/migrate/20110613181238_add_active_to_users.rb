class AddActiveToUsers < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :activo, :boolean, :default => true
    Usuario.update_all("activo = true")
  end

  def self.down
    remove_column :usuarios, :activo
  end
end
