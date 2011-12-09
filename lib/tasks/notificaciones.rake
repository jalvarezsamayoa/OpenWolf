namespace :notificaciones do

  desc "Notificacion a supervisores sobre solicitudes por vencer"
  task :solicitudes_por_vencer => :environment do

  
    Institucion.activas.each do |institucion|
      Notificaciones.delay.solicitudes_por_vencer(institucion)
    end
  
    
  end

end
