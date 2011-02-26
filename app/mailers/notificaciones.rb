# -*- coding: utf-8 -*-
class Notificaciones < ActionMailer::Base

  default :from => "notificaciones@openwolf.org"

  if Rails.env.development?
    default_url_options[:host] = "localhost:3000"
  else
    default_url_options[:host] = "transparencia.gob.gt"
  end
  
  # envia correo cuando se genera una nueva solicitud
  # para = [personaludip, ciudadano] 
  def nueva_solicitud(solicitud,  sent_at = Time.now)
    @solicitud = solicitud
    @url_solicitud = solicitud_portal_url(solicitud.id)

    email = solicitud.institucion.email
    correo_institucional = ( email.nil? ? '' : ', ' + email)
    
    mail(:to => solicitud.correos_interesados + correo_institucional,
         :subject => "openwolf - Confirmación nueva solicitud de información - #{solicitud.codigo}.")           
  end


  def nueva_asignacion(actividad, sent_at = Time.now)
    @actividad = actividad
    @url_solicitud = institucion_solicitud_url(actividad.institucion_id, actividad.solicitud_id)

    email = actividad.institucion.email
    correo_institucional = ( email.nil? ? '' : ', ' + email)
    
    mail(:to => actividad.usuario.email + correo_institucional,
         :subject => "openwolf - Nueva Asignación - Solicitud #{actividad.solicitud.codigo}")    
  end


  def nueva_resolucion(resolucion,sent_at = Time.now)
    @resolucion = resolucion
    @solicitud = resolucion.solicitud
    @url_solicitud =  solicitud_portal_url(resolucion.solicitud_id)

    email = @solicitud.institucion.email
    correo_institucional = ( email.nil? ? '' : ', ' + email)
    

    mail(:to => resolucion.solicitud.email + correo_institucional ,
         :subject => "openwolf - Aviso emisión de resolución - #{resolucion.numero}.")
    
  end


  def nueva_nota_seguimiento(nota)
    @nota = nota
    @solicitud = nota.proceso
    @url_solicitud = solicitud_portal_url(@solicitud.id)

    email = @solicitud.institucion.email
    correo_institucional = ( email.nil? ? '' : ', ' + email)
    
    
    mail(:to => @solicitud.correos_interesados + correo_institucional,
         :subject => "openwolf - Nueva nota seguimiento - Solicitud #{@solicitud.codigo}.")           
  end


end
