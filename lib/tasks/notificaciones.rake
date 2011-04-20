namespace :notificaciones do

  desc "Notificacion a supervisores sobre solicitudes por vencer"
  task :solicitudes_por_vencer => :environment do

    logger.info { "//// INICIO - NOTIFICACION - SOLICITUDES POR VENCER /////" }
    Institucion.activas.each do |institucion|
      logger.info { "Notificando a: #{institucion.nombre}" }
      Notificaciones.delay.solicitudes_por_vencer(institucion)
    end
    logger.info { "//// FIN - NOTIFICACION - SOLICITUDES POR VENCER /////" }
    
  end

end
