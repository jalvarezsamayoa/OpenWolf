require 'highline'


def get_institucion(ui)
  institucion_id = ui.ask("Ingrese ID de institucion: ")
  institucion = Institucion.find(institucion_id)
  ok = ui.ask("Desea actualizar #{institucion.nombre}? (y/n) ")
  if ok == 'y'
    return institucion
  else
    return nil
  end
end

def recalcular_tiempos_entrega(institucion)
  #actualizar tiempos de respuesta
  Solicitud.where("institucion_id = ?", institucion.id) \
    .update_all(:tiempo_respuesta => 0, :tiempo_respuesta_calendario => 0 )

  resoluciones = Resolucion.where("institucion_id = ?",institucion.id).finales
  n = resoluciones.count
  i = 0

  resoluciones.each do |resolucion|
    i += 1
    puts "#{institucion.nombre}: Actualizando resolucion #{i} de #{n}"
    resolucion.actualizar_solicitud
  end

  puts "Done!"
end

namespace :openwolf do

 

  namespace :cleanup do

     namespace :tiempos do

    desc "Recalcular tiempos de respuesta"
    task :all => :environment do

      #actualizar tiempos de respuesta
        Solicitud.update_all(:tiempo_respuesta => 0,
                             :tiempo_respuesta_calendario => 0)

      resoluciones = Resolucion.finales
      n = resoluciones.count
      i = 0

      resoluciones.each do |resolucion|
        i += 1
        puts "Actualizando resolucion #{i} de #{n}"
        resolucion.actualizar_solicitud
      end
    end

    desc "Recalcular tiempos de una institucion"
    task :one => :environment do
      ui = HighLine.new

      institucion_id = ui.ask("Ingrese ID de institucion: ")

      institucion = Institucion.find(institucion_id)
      ok = ui.ask("Desea actualizar #{institucion.nombre}? (y/n) ")
      if ok == 'y'

        #actualizar tiempos de respuesta
        Solicitud.where("institucion_id = ?", institucion.id) \
          .update_all(:tiempo_respuesta => 0, :tiempo_respuesta_calendario => 0 )

        resoluciones = Resolucion.where("institucion_id = ?",institucion.id).finales
        n = resoluciones.count
        i = 0

        resoluciones.each do |resolucion|
          i += 1
          puts "Actualizando resolucion #{i} de #{n}"
          resolucion.actualizar_solicitud
        end

        puts "Done!"
      end

    end

  end

    desc "Limpiar fecha de resoluciones"
    task :resoluciones => :environment do
      ui = HighLine.new
      institucion = get_institucion(ui)

      if institucion
        fecha_importacion = ui.ask("Ingrese fecha de importacion (yyyy-mm-dd): ")

        query = "update resoluciones
set fecha = solicitudes.fecha_completada
, fecha_notificacion = solicitudes.fecha_completada
from solicitudes
where resoluciones.institucion_id = #{institucion.id}
and resoluciones.fecha = '#{fecha_importacion}'
and resoluciones.solicitud_id = solicitudes.id"

        Resolucion.connection.execute(query)

        puts "Done"
        ok = ui.ask("Desea recalcular tiempos de entrega? (y/n): ")
        if ok == 'y'
          recalcular_tiempos_entrega(institucion)
        end


      end
    end #resolucones

    desc "Limpiar tiempos entrega en base a lista"
    task :resoluciones_list => :environment do

      instituciones = [[800, '2011-10-11'],
                       [242, '2011-10-14'],
                       [256, '2011-10-14'],
                       [257, '2011-10-15'],
                       [249, '2011-10-16'],
                       [233, '2011-10-10'],
                       [319, '2011-01-26'],
                       [259, '2011-09-20'],
                       [21, '2011-02-14'],
                       [806, '2011-10-16'],
                       [807, '2011-10-17'],
                       [757, '2011-09-29'],
                       [805, '2011-10-16'],
                       [309, '2011-02-03'],
                       [311, '2011-01-25'],
                       [251, '2011-10-14'],
                       [246, '2011-10-14'],
                       [254, '2011-10-14'],
                       [16, '2011-01-25']]

      instituciones.each do |institucion|
        
        fecha_importacion = institucion[1]
        institucion_id = institucion[0]

        institucion = Institucion.find(institucion_id)

        query = "update resoluciones
set fecha = solicitudes.fecha_completada
, fecha_notificacion = solicitudes.fecha_completada
from solicitudes
where resoluciones.institucion_id = #{institucion.id}
and resoluciones.fecha = '#{fecha_importacion}'
and resoluciones.solicitud_id = solicitudes.id"

        Resolucion.connection.execute(query)

     #   recalcular_tiempos_entrega(institucion)
      end

    end #resolucioes all

  end #cleanup

end #opwnwolf
