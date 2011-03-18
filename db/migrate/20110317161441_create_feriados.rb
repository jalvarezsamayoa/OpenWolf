class CreateFeriados < ActiveRecord::Migration
  def self.up
    create_table :feriados do |t|
      t.string :nombre, :null => false
      t.integer :dia, :null => false, :default => 1
      t.integer :mes, :null => false, :default => 1
      t.integer :institucion_id, :null => false, :default => 1
      t.integer :tipoferiado_id, :null => false, :default => 1

      t.timestamps
    end

    add_index :feriados, :dia
    add_index :feriados, :mes
    add_index :feriados, :institucion_id
    add_index :feriados, :tipoferiado_id
  end

  def self.down
    drop_table :feriados
  end
end
