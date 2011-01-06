class CreateRangosedad < ActiveRecord::Migration
  def self.up
    create_table :rangosedad do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :rangosedad
  end
end
