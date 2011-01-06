# OpenWolf  Copyright (C) 2010  Javier Alvarez (@JManGt)
# Este programa se ofrece SIN GARANTÍA ALGUNA; 
# Es software libre, y usted puede redistribuirlo bajo ciertas condiciones; 
# Lea README.rdoc para mas detalles; 
class CreateInstituciones < ActiveRecord::Migration
  def self.up
    create_table :instituciones do |t|
      t.string :nombre, :null => false
      t.integer :tipoinstitucion_id, :null => false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
                                     
      t.timestamps
    end

    add_index :instituciones, :tipoinstitucion_id
    add_index :instituciones, :parent_id
    add_index :instituciones, :lft
    add_index :instituciones, :rgt
    
  end

  def self.down
    drop_table :instituciones
  end
end
