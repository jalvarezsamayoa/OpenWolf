class AddUsuariosOpenIdField < ActiveRecord::Migration
  def self.up
      add_column :usuarios, :openid_identifier, :string
      add_index :usuarios, :openid_identifier

      change_column :usuarios, :username, :string, :default => nil, :null => true
      change_column :usuarios, :crypted_password, :string, :default => nil, :null => true
      change_column :usuarios, :password_salt, :string, :default => nil, :null => true
    end

    def self.down
      remove_column :usuarios, :openid_identifier

      [:username, :crypted_password, :password_salt].each do |field|
        User.all(:conditions => "#{field} is NULL").each { |user| user.update_attribute(field, "") if user.send(field).nil? }
        change_column :usuarios, field, :string, :default => "", :null => false
      end
    end
end
