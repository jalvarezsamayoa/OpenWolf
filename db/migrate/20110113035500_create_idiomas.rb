class CreateIdiomas < ActiveRecord::Migration
  def self.up
    create_table :idiomas do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :idiomas
  end
end
