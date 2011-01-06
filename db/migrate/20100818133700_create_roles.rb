class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string   :name,              :limit => 40
      t.string   :authorizable_type, :limit => 40
      t.integer  :authorizable_id

      t.timestamps
    end

    create_table :roles_usuarios, :id => false, :force => true do |t|
      t.integer  :usuario_id
      t.integer  :role_id
      t.timestamps
    end

    add_index :roles, :name
    add_index :roles, :authorizable_type
    add_index :roles, :authorizable_id

    add_index :roles_usuarios, :usuario_id
    add_index :roles_usuarios, :role_id
    
  end

  def self.down
    drop_table :roles
    drop_table :roles_usuarios
  end
end
