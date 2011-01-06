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
    @q = params[:q] if params[:q]
    
    if params[:commit].nil?
   
      @solicitudes = Solicitud.search do          
        keywords(params[:q])
        paginate(:page => (params[:page] ||= 1), :per_page => 10)
        order_by(:created_at, :desc)
      end
      @documentos = Documento.search do          
        keywords(params[:q])
        paginate(:page => (params[:page] ||= 1), :per_page => 10)
        order_by(:created_at, :desc)
      end
    else
      if params[:commit] == 'Buscar en OpenWolf'

        @solicitudes = Solicitud.search do          
          keywords(params[:q])
          paginate(:page => (params[:page] ||= 1), :per_page => 10)
          order_by(:created_at, :desc)
        end
        @documentos = Documento.search do          
          keywords(params[:q])
          paginate(:page => (params[:page] ||= 1), :per_page => 10)
          order_by(:created_at, :desc)
        end
        
      else
        # filtro de solicitudes
        c_filtro = ''
        
        #fechas
        if params[:fecha_desde] and params[:fecha_hasta]
          logger.debug { "#{params[:fecha_desde]}" }
          logger.debug { "#{Date.strptime(params[:fecha_desde], "%d/%m/%Y")}" }
          c_filtro = '.fecha_creacion_greater_than_or_equal_to(Date.strptime(params[:fecha_desde], "%d/%m/%Y"))'
          c_filtro += '.fecha_creacion_less_than_or_equal_to(Date.strptime(params[:fecha_hasta], "%d/%m/%Y"))'
        end

        #solicitante
        unless params[:solicitante_nombre].empty?
          c_filtro += '.solicitante_nombre_like(params[:solicitante_nombre])'
        end

        #texto solicitud
        unless params[:solicitud_texto].empty?                 
          c_filtro += '.textosolicitud_like(params[:solicitud_texto])'
        end

        #codigo solicitud
        unless params[:solicitud_codigo].empty?                 
          c_filtro += '.codigo_like(params[:solicitud_codigo])'
        end

        #via de solicitud
        unless params[:solicitud_via].empty?
          unless params[:solicitud_via] == 'Todos'
            c_filtro += '.via_id_equals(params[:solicitud_via])'
          end
        end

        #estado de solicitud
        unless params[:solicitud_estado].empty?
          unless params[:solicitud_estado] == 'Todos'
            c_filtro += '.estado_id_equals(params[:solicitud_estado])'
          end
        end

        #tiempo transcurrido
        # unless params[:solicitud_avance].empty?
        #   unless params[:solicitud_avance] == 'Todos'
        #      c_filtro += '.avance_id_equals(params[:solicitud_avance])'
        #   end
        # end

        c_comando =  "@solicitudes = Solicitud" + c_filtro + ".paginate(:page => params[:page], :per_page => 20)"
        eval(c_comando)
        
      end
    end
    
    @desde = Solicitud.minimum(:fecha_creacion)
    @hasta = Solicitud.maximum(:fecha_creacion)

    @desde = Date.today if @desde.nil?
    @hasta = Date.today if @hasta.nil?
  end

  def institucion
    @institucion = Institucion.find(params[:id])    
  end
end
