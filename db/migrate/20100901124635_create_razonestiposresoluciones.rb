class CreateRazonestiposresoluciones < ActiveRecord::Migration
  def self.up
    create_table :razonestiposresoluciones do |t|
      t.string :nombre, :null => false
      t.integer :tiporesolucion_id, :null => false

      t.timestamps
    end

    add_index :razonestiposresoluciones, :tiporesolucion_id
  end

  def self.down
    drop_table :razonestiposresoluciones
  end
end
