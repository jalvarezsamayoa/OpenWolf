class AddAttachmentsLogoToInstitucion < ActiveRecord::Migration
  def self.up
    add_column :instituciones, :logo_file_name, :string
    add_column :instituciones, :logo_content_type, :string
    add_column :instituciones, :logo_file_size, :integer
    add_column :instituciones, :logo_updated_at, :datetime
  end

  def self.down
    remove_column :instituciones, :logo_file_name
    remove_column :instituciones, :logo_content_type
    remove_column :instituciones, :logo_file_size
    remove_column :instituciones, :logo_updated_at
  end
end
