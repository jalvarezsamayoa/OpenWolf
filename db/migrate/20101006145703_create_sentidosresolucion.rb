class CreateSentidosresolucion < ActiveRecord::Migration
  def self.up
    create_table :sentidosresolucion do |t|
      t.string :nombre, :nil => false

      t.timestamps
    end
  end

  def self.down
    drop_table :sentidosresolucion
  end
end
