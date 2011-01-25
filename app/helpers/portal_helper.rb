module PortalHelper
  #genera el titulo de la pagina para SEO
  def solicitud_title(solicitud)
    solicitud.institucion.nombre + '- Solicitud No. ' + @solicitud.codigo
  end

  #genera el vinculo externo a una soliciut
  def link_to_solicitud_portal(solicitud, popup = false)
    return raw( link_to solicitud.codigo, solicitud_portal_path(:id => solicitud.id), :title => "Haga click para ver contendido de Solicitud.", :popup => popup  )
  end
end
