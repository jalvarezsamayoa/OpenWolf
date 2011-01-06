class CreateRecursosrevision < ActiveRecord::Migration
  def self.up
    create_table :recursosrevision do |t|
      t.integer :solicitud_id, :nil => false
      t.date :fecha_presentacion
      t.date :fecha_notificacion
      t.date :fecha_resolucion
      t.text :descripcion
      t.integer :sentidoresolucion_id, :nil => false
      t.integer :institucion_id, :nil => false
      t.integer :usuario_id, :nil => false

      t.timestamps
    end
    
    add_index :recursosrevision, :solicitud_id
    add_index :recursosrevision, :sentidoresolucion_id
    add_index :recursosrevision, :institucion_id
    add_index :recursosrevision, :usuario_id
  end

  def self.down
    drop_table :recursosrevision
  end
end
