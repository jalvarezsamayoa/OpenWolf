module DocumentosHelper
  def documento_boton_archivar(documento, hay_archivos = false)
    return '' unless hay_archivos
    raw( link_to( image_tag('folder16.png') + ' Archivar',        
                  archivar_documento_path(documento),
                  :class => 'button',
                  :remote => true,
                  :title => 'Archivar documento')
         )
    
  end

  def documento_boton_trasladar(documento, hay_archivos = false)
    return '' unless hay_archivos
    raw( link_to( image_tag('mail16.png') + ' Trasladar',        
                  trasladar_documento_path(documento),
                  :class => 'button',
                  :remote => true,
                  :title => 'Trasladar documento a enlaces')
         )
    
  end
  
end
