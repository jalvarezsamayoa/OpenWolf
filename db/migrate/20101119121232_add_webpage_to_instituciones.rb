class AddWebpageToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :webpage, :string
  end

  def self.down
    remove_column :instituciones, :webpage
  end
end
