class CreateClasificaciones < ActiveRecord::Migration
  def self.up
    create_table :clasificaciones do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :clasificaciones
  end
end
