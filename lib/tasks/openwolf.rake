namespace :openwolf do

    desc "Recalcular tiempos de respuesta"
    task :tiempos => :environment do

      #actualizar tiempos de respuesta
      Solicitud.update_all(:tiempo_respuesta => 0, :tiempo_respuesta_calendario => 0)
      solicitudes = Solicitud.conresolucionfinal
      n = solicitudes.count
      i = 0
      
      for s in solicitudes
        i += 1
        puts "Actualizando solicitud #{i} de #{n}"
        
        unless s.fecha_resolucion.nil?
          dias = (s.fecha_resolucion - s.fecha_creacion).to_i
          dias = 1 if dias == 0
          s.tiempo_respuesta_calendario = dias
          s.tiempo_respuesta = dias - Feriado.calcular_dias_no_laborales(:fecha => s.fecha_creacion,
                                                                         :dias => dias.to_i,
                                                                         :institucion_id => s.institucion_id)
        else
          s.tiempo_respuesta = 0
          s.tiempo_respuesta_calendario = 0
        end
        s.save(false)
      end
    end
    

end
