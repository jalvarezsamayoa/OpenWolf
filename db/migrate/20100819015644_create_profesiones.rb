class CreateProfesiones < ActiveRecord::Migration
  def self.up
    create_table :profesiones do |t|
      t.string :nombre, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :profesiones
  end
end
