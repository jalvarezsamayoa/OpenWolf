class CreateFuentes < ActiveRecord::Migration
  def self.up
    create_table :fuentes do |t|
      t.string :nombre, :null => false                         

      t.timestamps
    end
  end

  def self.down
    drop_table :fuentes
  end
end
