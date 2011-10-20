class CreateTempAssets < ActiveRecord::Migration
  def self.up
    create_table :temp_assets, :force => true do |t|
      t.integer :institucion_id
      t.integer :usuario_id
      t.text :options
      t.timestamps
    end
  end

  def self.down
    drop_table :temp_assets
  end
end
