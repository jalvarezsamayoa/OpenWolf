class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    
    rename_column :usuarios, :crypted_password, :encrypted_password

    add_column :usuarios, :confirmation_token, :string, :limit => 255
    add_column :usuarios, :confirmed_at, :timestamp
    add_column :usuarios, :confirmation_sent_at, :timestamp
    execute "UPDATE usuarios SET confirmed_at = created_at, confirmation_sent_at = created_at"
    add_column :usuarios, :reset_password_token, :string, :limit => 255

    add_column :usuarios, :remember_token, :string, :limit => 255
    add_column :usuarios, :remember_created_at, :timestamp
    rename_column :usuarios, :login_count, :sign_in_count
    rename_column :usuarios, :current_login_at, :current_sign_in_at
    rename_column :usuarios, :last_login_at, :last_sign_in_at
    rename_column :usuarios, :current_login_ip, :current_sign_in_ip
    rename_column :usuarios, :last_login_ip, :last_sign_in_ip

    rename_column :usuarios, :failed_login_count, :failed_attempts
    add_column :usuarios, :unlock_token, :string, :limit => 255
    add_column :usuarios, :locked_at, :timestamp

    remove_column :usuarios, :persistence_token
  #  remove_column :usuarios, :perishable_token
 #   remove_column :usuarios, :single_access_token

  #  add_index :usuarios, :email,                :unique => true
    add_index :usuarios, :confirmation_token,   :unique => true
    add_index :usuarios, :reset_password_token, :unique => true
    add_index :usuarios, :unlock_token,         :unique => true
    
  end

  def self.down   
  end
end
