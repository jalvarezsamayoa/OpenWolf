# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


# Resolucion.all.each { |r|
# #  if r.fecha.nil?
#     r.fecha = r.created_at.to_date
#     r.fecha_notificacion = r.created_at.to_date
#     r.save!
# #  end
# }

puts "reiniciar passwords"
Usuario.all.each do |u|
  u.password = '123456'
  u.password_confirmation = '123456'
  u.save!
end

# puts "Limpiar data..."
# Documento.all.each do |d|
#   d.delete if d.autor.nil?
# end

# Institucion.all.each do |i|
#   puts i.nombre
#   unless i.valid?
#     i.email = 'notificaciones@openwolf.org'
#     i.save!
#   end
#  end

# Actividad.all.each do |a|
#   if a.solicitud.nil?
#     a.destroy
#   end
# end

# require 'active_record/fixtures'
# Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "feriados")

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




                                  


