module SolicitudesHelper

  def solicitud_boton_regresar
    raw(link_to(image_tag('undo16.png') + t("data.back"),
                solicitudes_path,
                :class => 'button' )
        )
  end

  def solicitud_boton_imprimir(solicitud, mostrar = true)
    return '' if !mostrar or solicitud.anulada?
    raw( link_to(image_tag('printer16.png') + t("data.print"),
                 print_portal_url(solicitud, :format => 'pdf'),
                 :class => 'button', :popup => true )
         )
  end

  def solicitud_boton_editar(solicitud, pertinente = false, supervisor = false)
    return '' if !(pertinente && supervisor) or solicitud.anulada?
    raw( link_to( image_tag('edit16.png') + t("data.edit"),        
                  edit_institucion_solicitud_path(solicitud.institucion_id,solicitud),
                  :class => 'button' )
         )
  end

  def solicitud_boton_eliminar(solicitud, pertinente = false, supervisor = false)
    return '' if !(pertinente && supervisor) or solicitud.anulada?
    raw( link_to(image_tag('delete16.png') + 'Anular', 
                 institucion_solicitud_path(solicitud.institucion_id,solicitud),  
                 :class => 'button negative',                                   
                 :confirm => t("data.rusure"),                         
                 :method => :delete,
                 :title => "Anular solicitud")                                  
         )
  end

  def solicitud_boton_asignar_enlace(solicitud, pertinente = false, udip = false)
    return '' if !(!@solicitud.entregada? && pertinente && udip) or solicitud.anulada?
    raw( link_to(image_tag('adduser16.png') + t("actividades.title_new"),    
                 new_institucion_solicitud_actividad_path(solicitud.institucion_id, solicitud), 
                 :title => 'Asignar solicitud a responsable',                        
                 :class => 'button',                                                 
                 :method => :get,                                                    
                 :remote => true )
         )
  end

  def solicitud_boton_adjuntar_documento(solicitud, pertinente = false, udip = false)
    return '' if !(pertinente && udip) or solicitud.anulada?
    raw( link_to(image_tag("textfile16.png") + t("solicitudes.label_adjuntaradjunto"), 
                 new_solicitud_adjunto_path(@solicitud),                                       
                 :title => 'Adjuntar archivos a Solicitud',                       
                 :class => 'button',                                                           
                 :method => :get,                                                    
                 :remote => true )
         )
  end

  def solicitud_boton_emitir_resolucion(solicitud, pertinente = false, supervisor = false)
    return '' if !(solicitud.asignada? && pertinente && supervisor) or solicitud.anulada?
    return '' if solicitud.entregada?
    raw( link_to(image_tag("refresh16.png") +  t("solicitudes.label_resoluciones"),           
                 solicitud_resoluciones_path(solicitud),                             
                 :id=>'link_new_resolucion',
                 :class => 'button')
         )
  end

  def solicitud_boton_recurso_revision(solicitud, pertinente = false, udip = false)
    return '' if !(solicitud.entregada? and pertinente and udip) or solicitud.anulada?
    raw( link_to(image_tag("cut16.png") +  t("solicitudes.label_recursosrevision"),
                 solicitud_recursosrevision_path(solicitud),
                 :id=>'link_new_recursorevision',
                 :class => 'button' )
         )
  end

  def solicitud_boton_seguimientos(solicitud, pertinente = false, supervisor = false)
    return '' if !(pertinente && supervisor) or solicitud.anulada?
    raw( link_to( image_tag('chat16.png') + Solicitud.human_attribute_name(:notas),        
                  solicitud_notas_path(solicitud),
                  :class => 'button',
                  :title => 'Notas de Seguimiento para Solicitud')
         )
    
  end

  def actividad_boton_agregar_seguimiento(actividad)
    return '' if actividad.solicitud.anulada?
    return '' if actividad.nil?
    raw (link_to(image_tag("addfile16.png")+' Agregar Seguimiento',
                   new_institucion_solicitud_actividad_seguimiento_path(actividad.institucion_id, actividad.solicitud_id,  actividad.id), 
                   :method => :get,
                   :remote => true,
                   :class => 'button',
                   :title => 'Agregar seguimiento a tareas asignada.'))
  end

  
  
end
