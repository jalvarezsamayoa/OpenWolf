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
      format.xml  { render :xml => @solicitud }
     # format.pdf {render :layout => 'print'}
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
        
    @solicitudes = Solicitud.buscar(params)
    

    @desde = ( params[:fecha_desde] ? Date.strptime(params[:fecha_desde], "%d/%m/%Y") : Date.today - Date.today.yday + 1 )
    @hasta = ( params[:fecha_hasta] ? Date.strptime(params[:fecha_hasta], "%d/%m/%Y") : Date.today )

    @q = params[:search]
  end

  def institucion
    @institucion = Institucion.find(params[:id])    
  end
end
