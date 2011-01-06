class CreateMotivosnegativa < ActiveRecord::Migration
  def self.up
    create_table :motivosnegativa do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :motivosnegativa
  end
end
