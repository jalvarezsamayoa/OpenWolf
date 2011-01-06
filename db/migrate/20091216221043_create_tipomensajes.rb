class CreateTipomensajes < ActiveRecord::Migration
  def self.up
    create_table :tipomensajes do |t|
      t.string :nombre, :null => false                        

      t.timestamps
    end
  end

  def self.down
    drop_table :tipomensajes
  end
end
