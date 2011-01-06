class CreateSolicitudes < ActiveRecord::Migration
  def self.up
    create_table :solicitudes do |t|
      t.integer :usuario_id, :null => false                             
      t.string :codigo, :null => false, :default => 'XXXXX-999999-9999'
      t.integer :institucion_id, :null => false
      t.integer :tiposolicitud_id, :default => 1
      t.integer :via_id, :null => false, :default => 1
      t.date :fecha_creacion
      t.date :fecha_programada
      t.date :fecha_entregada
      t.date :fecha_resolucion
      t.date :fecha_prorroga
      t.date :fecha_completada
      t.string :solicitante_nombre, :null => false
      t.string :solicitante_identificacion
      t.string :solicitante_direccion
      t.string :solicitante_telefonos
      t.string :solicitante_institucion
      t.integer :departamento_id
      t.integer :municipio_id
      t.string :email
      t.string :forma_entrega
      t.text :observaciones
      t.string :ubicacion_url
      t.integer :estado_id, :default => 1

      t.timestamps
    end

    add_index :solicitudes, :usuario_id
    add_index :solicitudes, :codigo
    add_index :solicitudes, :institucion_id
    add_index :solicitudes, :tiposolicitud_id
    add_index :solicitudes, :via_id
    add_index :solicitudes, :fecha_creacion
    add_index :solicitudes, :fecha_programada
    add_index :solicitudes, :fecha_entregada
    add_index :solicitudes, :fecha_resolucion
    add_index :solicitudes, :fecha_prorroga
    add_index :solicitudes, :fecha_completada
    add_index :solicitudes, :solicitante_nombre
    add_index :solicitudes, :solicitante_institucion
    add_index :solicitudes, :departamento_id
    add_index :solicitudes, :municipio_id
    add_index :solicitudes, :estado_id
        
  end

  def self.down
    drop_table :solicitudes

    remove_index :solicitudes, :usuario_id
    remove_index :solicitudes, :codigo
    remove_index :solicitudes, :institucion_id
    remove_index :solicitudes, :tiposolicitud_id
    remove_index :solicitudes, :via_id
    remove_index :solicitudes, :fecha_creacion
    remove_index :solicitudes, :fecha_programada
    remove_index :solicitudes, :fecha_entregada
    remove_index :solicitudes, :fecha_resolucion
    remove_index :solicitudes, :fecha_prorroga
    remove_index :solicitudes, :solicitante_nombre
    remove_index :solicitudes, :solicitante_institucion
    remove_index :solicitudes, :departamento_id
    remove_index :solicitudes, :municipio_id
    remove_index :solicitudes, :estado_id
  end
end
