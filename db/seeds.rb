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


#iniciar alias pdh
    # Tiporesolucion.all.each do |tr|
    #   tr.aliaspdh = tr.nombre
    #   tr.save(false)
# end

#iniciar anuladas
#Solicitud.update_all(:anulada => false)



# #limpiar fecha resoluciones
# puts "eliminando"
# Resolucion.all.each do |r|
#   r.delete if r.solicitud.nil?
# end
# puts 'ok'

# n = Resolucion.count
# i = 0
# Resolucion.all.each do |resolucion|
#   puts "Procesando #{i} de #{n}, id: #{resolucion.id}"
#   resolucion.solicitud.fecha_resolucion = resolucion.fecha
#   resolucion.save(false)
#   i += 1
# end
# puts 'Ok'

#limpiar estados de resoluciones
# n = Solicitud.conresolucion.count
# i = 1
# Solicitud.conresolucion.each do |solicitud|
#   puts "Procesando #{i} de #{n}, id: #{solicitud.id}"
#   #ultima resolucion
#   resolucion = solicitud.resoluciones.last
#   if solicitud.estado_id != resolucion.tiporesolucion.estado_id
#     solicitud.estado_id = resolucion.tiporesolucion.estado_id
#     solicitud.fecha_resolucion = resolucion.fecha
#     solicitud.save(false)
#   end
#   i += 1
# end



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




                                  


