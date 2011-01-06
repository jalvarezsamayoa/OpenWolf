class CreateDocumentos < ActiveRecord::Migration
  def self.up
    create_table :documentos do |t|
      t.string :numero, :null => false
      
      t.integer :origen_id, :null => false, :default => 1 # 1 Interno 2 Externo
      t.integer :documentoclasificacion_id, :null => false #memo, oficio
      t.integer :documentocategoria_id, :null => false # fondo, serie
      
      t.date :fecha_documento, :null => false
      t.integer :autor_id, :null => false 
      t.string :asunto, :null => false
      t.text :texto
       
          
      t.date :fecha_recepcion
      t.string :remitente_nombre
      t.text :remitente_direccion
      t.string :remitente_telefonos
      t.string :remitente_email

      t.integer :estado_envio_id, :null => false, :default => 1  # 1 Borrador 2 Enviado
      t.boolean :original, :null => false
        
      t.integer :usuario_id, :null => false  #crea documento      
      t.integer :institucion_id, :null => false #crea documemto
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      
      
      t.timestamps
    end

    add_index :documentos, :numero
    add_index :documentos, :origen_id
    add_index :documentos, :documentoclasificacion_id
    add_index :documentos, :documentocategoria_id
    add_index :documentos, :fecha_documento
    add_index :documentos, :autor_id
    add_index :documentos, :fecha_recepcion
    add_index :documentos, :estado_envio_id
    add_index :documentos, :original
    add_index :documentos, :usuario_id
    add_index :documentos, :institucion_id
    add_index :documentos, :parent_id
    add_index :documentos, :lft
    add_index :documentos, :rgt
    
  end

  def self.down
    drop_table :documentos    
  end
end
