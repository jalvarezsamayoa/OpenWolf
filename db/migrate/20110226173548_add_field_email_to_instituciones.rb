class AddFieldEmailToInstituciones < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :email, :string
  end

  def self.down
    remove_column :instituciones, :email
  end
end
