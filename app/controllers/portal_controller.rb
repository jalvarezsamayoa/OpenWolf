# -*- coding: utf-8 -*-
class PortalController < ApplicationController
  before_filter :get_solicitud, :only => [:solicitud, :print]

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



    @actividades = @solicitud.actividades
    @documentos = @solicitud.adjuntos

    @page_title = @solicitud.institucion.nombre + ' ('+ @solicitud.institucion.abreviatura + ') - Solicitud No. ' + @solicitud.codigo
    @q = @solicitud.codigo

    @restringir_seguimientos_privados = true

    @informacion_publica = @solicitud.puede_mostrar_informacion?


    mostrar_datos_solicitante()

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitud.to_xml(:include => @solicitud.xml_options ) }
    end


  end

  def print
    @actividades = @solicitud.actividades
    @documentos = @solicitud.adjuntos

    mostrar_datos_solicitante()

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

    csv_string = Solicitud.export_to_csv(:solicitudes => @solicitudes)

    send_data csv_string, :type => "text/plain",
    :filename=>"resultados_busqueda.csv",
    :disposition => 'attachment'

  end

  private

  def get_solicitud
    @solicitud = Solicitud.find(params[:id])

    if (@solicitud.nil? or @solicitud.anulada?)
      flash[:notice] = "Lo sentimos la información de la solicitud no esta disponible."
      redirect_to root_url
    end
  end

  def mostrar_datos_solicitante
    if usuario_actual
      @es_pertinente_a_usuario = @solicitud.es_pertinente?(usuario_actual)
      @usuario_es_supervisor =  nivel_seguridad(usuario_actual,'encargadoudip')
      @usuario_es_udip = nivel_seguridad(usuario_actual,'personaludip')

      @mostrar_datos_solicitante = (@es_pertinente_a_usuario and (@usuario_es_supervisor or @usuario_es_udip))
    else
      @mostrar_datos_solicitante = false
    end
  end

end
