class CreateTiposresoluciones < ActiveRecord::Migration
  def self.up
    create_table :tiposresoluciones do |t|
      t.string :nombre, :null => false
      t.boolean :actualiza_fecha, :default => false
      t.integer :estado_id, :null => false, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :tiposresoluciones
  end
end
