class SolicitudesController < ApplicationController
  before_filter :requiere_usuario, :except => [:print]
  before_filter :get_institucion, :except => [:cambiar_estado, :actualizar_estado, :marcar_entregada, :print]
  before_filter :get_data, :except => [:find, :print]
 

  # GET /solicitudes/new
  # GET /solicitudes/new.xml
  def new
    @solicitud = Solicitud.new
    @solicitud.fecha_creacion = l(Date.today)
    @solicitud.solicitante_nombre = ""
    @solicitud.solicitante_identificacion = "No Disponible"
    @solicitud.motivonegativa_id = 1
    @solicitud.motivoprorroga_id = 1
   
    @usa_solicitudes_privadas = usuario_actual.institucion.usasolicitudesprivadas

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @solicitud }
    end
  end

  # POST /solicitudes
  # POST /solicitudes.xml
  def create
    @solicitud = Solicitud.new(params[:solicitud])    
    @solicitud.usuario_id = usuario_actual.id
    @solicitud.origen_id = Solicitud::ORIGEN_DEFAULT
    
    respond_to do |format|
      if @solicitud.save
        flash[:success] = 'Solicitud creada con exito.'
        format.html { redirect_to institucion_solicitud_path(@institucion, @solicitud) }
        format.xml  { render :xml => @solicitud, :status => :created, :location => @solicitud }
      else
        logger.debug { "Error #{@solicitud.errors.inspect}" }
        format.html { render :action => "new" }
        format.xml  { render :xml => @solicitud.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # GET /solicitudes
  # GET /solicitudes.xml
  def index
    @solicitudes = Solicitud.all

    @noasignadas = usuario_actual.institucion.solicitudes.noasignadas
    @entramite = usuario_actual.institucion.solicitudes.asignadas.nocompletadas
    @terminadas = usuario_actual.institucion.solicitudes.completadas.conresolucion.noentregadas
    @pendresolucion = usuario_actual.institucion.solicitudes.completadas.sinresolucion
    
    @asignaciones = usuario_actual.actividades.nocompletadas

   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @solicitudes }
    end
  end

  # GET /solicitudes/1
  # GET /solicitudes/1.xml
  def show
    @solicitud = Solicitud.find(params[:id])
    @actividades = @solicitud.actividades
    @documentos = @solicitud.adjuntos
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitud }
    end
  end


  # GET /solicitudes/1/edit
  def edit
    @solicitud = Solicitud.find(params[:id])
  end


  # PUT /solicitudes/1
  # PUT /solicitudes/1.xml
  def update
    @solicitud = Solicitud.find(params[:id])

    respond_to do |format|
      if @solicitud.update_attributes(params[:solicitud])
        flash[:notice] = 'Solicitud actualizada con exito.'
        format.html { redirect_to institucion_solicitud_path(@institucion, @solicitud) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @solicitud.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /solicitudes/1
  # DELETE /solicitudes/1.xml
  def destroy
    @solicitud = Solicitud.find(params[:id])
    @solicitud.destroy

    respond_to do |format|
      format.html { redirect_to(solicitudes_url) }
      format.xml  { head :ok }
    end
  end

  #inicia ciclo para cambio de estado
  def cambiar_estado
    @solicitud = Solicitud.find(params[:id])
    @estados = Estado.all(:order => 'nombre')
    respond_to do |format|
      format.js
    end
  end

  #actualiza el estado de la solicitud
  def actualizar_estado
    @solicitud = Solicitud.find(params[:id])

    respond_to do |format|
      format.js do
        if @solicitud.update_attributes(params[:solicitud])
          flash[:success] = 'Estado actualizado con exito.'                  
        end        
      end
    end
    
  end

  #marcar como entregada
  def marcar_entregada
    @solicitud = Solicitud.find(params[:id])
    @solicitud.solicitud_entregada
    respond_to do |format|
      format.html do
        flash[:notice] = 'Solicitud fue marcada como entregada.'
        redirect_to solicitud_url(@solicitud)
      end
    end
  end


  #imprime en pdf
  def print
    respond_to do |format|
      format.html {render :layout => 'print'}
    end
  end

  def actualizar_municipios
    depto = Departamento.find(params[:departamento_id])
    @municipios = depto.municipios
     respond_to do |format|
      format.js do
        render :actualizar_municipios
      end
    end
  end

  #busca solicitudes
  def find
    if params[:filtrar].nil?
      logger.debug { "No hay filtro" }
      if params[:search]
        logger.debug { "Hay P Search" }
        @solicitudes = Solicitud.codigo_or_solicitante_nombre_or_textosolicitud_like(params[:search]).paginate(:page => params[:page], :per_page => 20)
      else
        logger.debug { "No hay P Search" }
        @solicitudes = nil
      end
    else
      unless params[:filtrar] == "true"
        logger.debug { "Filtrar = false" }
        @solicitudes = Solicitud.codigo_or_solicitante_nombre_or_textosolicitud_like(params[:search]).paginate(:page => params[:page], :per_page => 20)
      else
        logger.debug { "Filtrar = true" }
        # filtro de solicitudes
        c_filtro = ''

        #institucion
        unless params[:institucion_id] == 'ALL'
          c_filtro = '.institucion_id_equals(params[:institucion_id])'
        end
        
        #fechas
        if params[:fecha_desde] and params[:fecha_hasta]
          logger.debug { "#{params[:fecha_desde]}" }
          logger.debug { "#{Date.strptime(params[:fecha_desde], "%d/%m/%Y")}" }
          c_filtro += '.fecha_creacion_greater_than_or_equal_to(Date.strptime(params[:fecha_desde], "%d/%m/%Y"))'
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

#        tiempo transcurrido
         unless params[:solicitud_tiempo].empty?
           unless params[:solicitud_tiempo] == 'ALL'
             case params[:solicitud_tiempo]
             when '0a3'
               desde = 0
               hasta = 3
             when '4a6'
               desde = 4
               hasta = 6
             when '7a9'
               desde = 7
               hasta = 9
             when '10'
               desde = 10
               hasta = 10
             when 'LATE'
               hasta = -1
               desde = -100000
             end
              c_filtro += '.tiempo_restante(desde,hasta)'
           end
         end

        c_comando =  "@solicitudes = Solicitud.recientes" + c_filtro + ".paginate(:page => params[:page], :per_page => 20)"
        logger.debug { "filtro: #{c_comando}" }
        eval(c_comando)
        
      end
    end
    
    @desde = Solicitud.minimum(:fecha_creacion)
    @hasta = Solicitud.maximum(:fecha_creacion)

    @desde = Date.today if @desde.nil?
    @hasta = Date.today if @hasta.nil?
  end

  private

  def get_institucion    
    @institucion = usuario_actual.institucion
  end

  def get_data
    @vias = Via.all
    @municipios = Departamento.first.municipios.all(:order => "municipios.nombre")
  end
end
