class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :username
      t.string :email
      t.string :nombre
      t.string :cargo
      t.integer :departamento_id
      t.integer :areadocumento_id
      t.integer :puesto_id
      t.integer :institucion_id
      t.boolean :essupervisorarea
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      t.timestamps
    end

    add_index :usuarios, :username
    add_index :usuarios, :email
    add_index :usuarios, :departamento_id
    add_index :usuarios, :areadocumento_id
    add_index :usuarios, :puesto_id
    add_index :usuarios, :institucion_id
    
  end

  def self.down
    drop_table :usuarios
  end
end
