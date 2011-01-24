# -*- coding: utf-8 -*-
class Notificaciones < ActionMailer::Base

  if Rails.env.development?
    default_url_options[:host] = "localhost:3000"
  else
    default_url_options[:host] = "transparencia.gob.gt"
  end
  
  # envia correo cuando se genera una nueva solicitud
  # para = [personaludip, ciudadano] 
  def nueva_solicitud(solicitud,  sent_at = Time.now)
    subject    "openwolf - Confirmación nueva solicitud de información - #{solicitud.codigo}."
    recipients solicitud.correos_interesados
    from       'notificaciones@openwolf.org'
    sent_on    sent_at
    content_type "text/html"
    
    body       :solicitud => solicitud, :url_solicitud => solicitud_portal_url(solicitud.id)
  end

  def cambio_estado(sent_at = Time.now)
    subject    'Notificaciones#cambio_estado'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def nueva_asignacion(actividad, sent_at = Time.now)
    subject    "openwolf - Nueva Asignación - Solicitud #{actividad.solicitud.codigo}"
    recipients actividad.usuario.email
    from       'notificaciones@openwolf.org'
    sent_on    sent_at
    content_type "text/html"

    body       :actividad => actividad, :url_solicitud => institucion_solicitud_url(actividad.institucion_id, actividad.solicitud_id)
    
  end

  def nueva_nota_seguimiento(nota, sent_at = Time.now)
    solicitud = nota.solicitud
    
    subject    "openwolf - Nueva Nota de Seguimiento - Solicitud #{solicitud.codigo}"
    recipients solicitud.correos_interesados
    from       'notificaciones@openwolf.org'
    sent_on    sent_at
    content_type "text/html"

    body       :solicitud => solicitud, :nota => nota, :url_solicitud => solicitud_portal_url(solicitud.id)
    
  end

  def asignacion_completada(sent_at = Time.now)
    subject    'Notificaciones#asignacion_completada'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def nueva_resolucion(resolucion,sent_at = Time.now)
    subject    "openwolf - Aviso emisión de resolución - #{resolucion.numero}."
    recipients resolucion.solicitud.email
    from       'notificaciones@openwolf.org'
    sent_on    sent_at
    content_type "text/html"
    
    body       :resolucion => resolucion, :solicitud => resolucion.solicitud, :url_solicitud => solicitud_portal_url(resolucion.solicitud_id)   
  end

  def solicitud_completa(sent_at = Time.now)
    subject    'Notificaciones#solicitud_completa'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
