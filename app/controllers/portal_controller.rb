class PortalController < ApplicationController
  def index
  end

  def documento
    @documento = Documento.find(params[:id])

    @page_title = @documento.institucion.nombre + ' ('+ @documento.institucion.abreviatura + ') - Documento No. ' + @documento.numero
    @q = @documento.numero
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documento }
      #      format.pdf {render :layout => 'print'}
    end
  end

  def print_documento
    @documento = Documento.find(params[:id])
    respond_to do |format|
      format.html {render 'documento', :layout => 'print'}
    end
  end

  def solicitud
    @solicitud = Solicitud.find(params[:id])
    @actividades = @solicitud.actividades
    @documentos = @solicitud.adjuntos

    @page_title = @solicitud.institucion.nombre + ' ('+ @solicitud.institucion.abreviatura + ') - Solicitud No. ' + @solicitud.codigo
    @q = @solicitud.codigo

    @restringir_seguimientos_privados = true
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitud.to_xml(:include => @solicitud.xml_options ) }
    end
  end

  def print
    @solicitud = Solicitud.find(params[:id])
    @actividades = @solicitud.actividades
    @documentos = @solicitud.adjuntos
    respond_to do |format|
      format.html {render 'solicitud', :layout => 'print'}
    end
  end
  
  def buscar
    
    # guardamos el estado del filtro para agregarlo a la paginacion
    if params[:filtrar]
      @filtros = params
    else
      @filtros = nil
    end

    session[:last_search] = params
    
    @solicitudes = Solicitud.buscar(params)
    

    @desde = ( params[:fecha_desde] ? Date.strptime(params[:fecha_desde], "%d/%m/%Y") : Date.today - Date.today.yday + 1 )
    @hasta = ( params[:fecha_hasta] ? Date.strptime(params[:fecha_hasta], "%d/%m/%Y") : Date.today )

    @q = params[:search]
  end

  def institucion
    @institucion = Institucion.find(params[:id])    
  end

  def exportar
    # guardamos el estado del filtro para agregarlo a la paginacion
    params = session[:last_search]
    params[:per_page] = Solicitud.count
    
    @solicitudes = Solicitud.buscar(params)

    logger.debug { ">>>>>>>>>>>>>>>>>  #{@solicitudes.results.size}" }

    csv_string = FasterCSV.generate do |csv| 
      csv <<  [Solicitud.human_attribute_name(:rpt_institucion),
               Solicitud.human_attribute_name(:rpt_correlativo),
               Solicitud.human_attribute_name(:rpt_solicitud),
               Solicitud.human_attribute_name(:rpt_fechasolicitud),
               Solicitud.human_attribute_name(:rpt_tipodesolicitud),
               Solicitud.human_attribute_name(:rpt_tipoderesolucion),
               Solicitud.human_attribute_name(:rpt_fecharesolucion),
               Solicitud.human_attribute_name(:rpt_razonnopositiva),               
               Solicitud.human_attribute_name(:rpt_tiempoderespuesta),
               Solicitud.human_attribute_name(:rpt_sehasolicitadoampliacion),
               Solicitud.human_attribute_name(:rpt_fechanotificacionampliacion),
               Solicitud.human_attribute_name(:rpt_razonampliacion),
               Solicitud.human_attribute_name(:rpt_tiemposolicitadoampliacion),
               Solicitud.human_attribute_name(:rpt_recursorevision),
               Solicitud.human_attribute_name(:rpt_fechapresentacionrecursorevision),
               Solicitud.human_attribute_name(:rpt_fechanotificacionrecursorevision),
               Solicitud.human_attribute_name(:rpt_sentidoresolucion)]
     
      @solicitudes.each_hit_with_result do |hit, s|
        csv << [s.institucion.nombre,
                s.codigo,
                s.textosolicitud,
                l(s.fecha_creacion).to_s,
                (s.via.nil? ? '' : s.via.nombre),
                s.tipo_resolucion,
                (l(s.fecha_resolucion).to_s unless s.fecha_resolucion.nil?),
                s.razon_nopositiva,
                s.tiempo_respuesta.to_s,
                s.hay_prorroga,
                (l(s.fecha_notificacion_prorroga).to_s),
                s.razon_prorroga,
                s.tiempo_ampliacion.to_s,
                s.hay_revision,
                (l(s.fecha_revision).to_s unless s.fecha_revision.empty?),
                (l(s.fecha_notificacion_revision).to_s unless s.fecha_notificacion_revision.nil? or s.fecha_notificacion_revision.empty?),
                s.razon_resolucion]
      end
    end
    send_data csv_string, :type => "text/plain", 
    :filename=>"resultados_busqueda.csv",
    :disposition => 'attachment'
    
  end
  
end
