module PortalHelper
  #genera el titulo de la pagina para SEO
  def solicitud_title(solicitud)
    solicitud.institucion.nombre + '- Solicitud No. ' + @solicitud.codigo
  end
end
