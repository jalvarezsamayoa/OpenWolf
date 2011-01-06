class CreateMotivosprorroga < ActiveRecord::Migration
  def self.up
    create_table :motivosprorroga do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :motivosprorroga
  end
end
