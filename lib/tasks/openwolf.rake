namespace :openwolf do

  desc "Recalcular tiempos de respuesta"
  task :tiempos => :environment do

    #actualizar tiempos de respuesta
    Solicitud.update_all(:tiempo_respuesta => 0, :tiempo_respuesta_calendario => 0)

    resoluciones = Resolucion.finales
    n = resoluciones.count
    i = 0

    resoluciones.each do |resolucion|
      i += 1
      puts "Actualizando resolucion #{i} de #{n}"
      resolucion.actualizar_solicitud
    end

  end

end
