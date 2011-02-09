# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


Resolucion.all.each { |r|
#  if r.fecha.nil?
    r.fecha = r.created_at.to_date
    r.fecha_notificacion = r.created_at.to_date
    r.save!
#  end
}



# puts 'Crear Maestros...'
# load "#{Rails.root}/db/create_maestros.rb"
# #puts 'Crear Instituciones' 
# #load "#{Rails.root}/db/create_instituciones.rb"
# #load "#{Rails.root}/db/create_entidadades.rb"

# root = Institucion.find(1)
# root.parent = nil
# root.save!

# #puts 'Crear Usuarios...'
# load "#{Rails.root}/db/create_usuarios.rb"
# #puts 'Crear Solicitudes...'
# #load "#{Rails.root}/db/create_solicitudes.rb"

# puts 'Activando Instituciones'
#  i = Institucion.find_by_abreviatura('VDLR')
#  i.activa = true
# i.save


 #i = Institucion.find_by_abreviatura('MDAYRN')
 #i.activa = true
#i.save




                                  


