class CreateNotas < ActiveRecord::Migration
  def self.up
    create_table :notas do |t|
      t.integer :proceso_id
      t.string :proceso_type
      t.integer :usuario_id
      t.text :texto

      t.timestamps
    end

    add_index :notas, :proceso_id
    add_index :notas, :proceso_type
    add_index :notas, :usuario_id
    
  end

  def self.down
    drop_table :notas
  end
end
