class CreateDocumentocategorias < ActiveRecord::Migration
  def self.up
    create_table :documentocategorias do |t|
      t.string :nombre
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end

    add_index :documentocategorias, :parent_id
    add_index :documentocategorias, :lft
    add_index :documentocategorias, :rgt
  end

  def self.down
    drop_table :documentocategorias
  end
end
