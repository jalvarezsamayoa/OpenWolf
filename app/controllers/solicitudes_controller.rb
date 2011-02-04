class SolicitudesController < ApplicationController
  before_filter :requiere_usuario, :except => [:print]
  before_filter :get_institucion, :except => [:cambiar_estado, :actualizar_estado, :marcar_entregada, :print]
  before_filter :get_data, :except => [:find, :print]
  

  # GET /solicitudes
  # GET /solicitudes.xml
  def index
    @solicitudes = Solicitud.all

    @usuario_es_udip = nivel_seguridad(usuario_actual,'personaludip')

    if @usuario_es_udip
      
      @noasignadas = usuario_actual.institucion.solicitudes.noasignadas.recientes.correlativo
      @entramite = usuario_actual.institucion.solicitudes.asignadas.nocompletadas.recientes.correlativo
      @terminadas = usuario_actual.institucion.solicitudes.completadas.conresolucion.noentregadas.recientes.correlativo
      @pendresolucion = usuario_actual.institucion.solicitudes.completadas.sinresolucion.recientes.correlativo
      @entregadas = usuario_actual.institucion.solicitudes.entregadas.recientes.correlativo
    else
      @noasignadas = nil
      @entramite = nil
      @terminadas = nil
      @pendresolucion = nil
      @entregadas = nil
    end
    
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
    @adjuntos = @solicitud.adjuntos

    @es_pertinente_a_usuario = @solicitud.es_pertinente?(usuario_actual)
    @usuario_es_supervisor =  nivel_seguridad(usuario_actual,'encargadoudip')
    @usuario_es_udip = nivel_seguridad(usuario_actual,'personaludip')

    @puede_remover = (@es_pertinente_a_usuario && @usuario_es_udip)
    @restringir_seguimientos_privados = !(@es_pertinente_a_usuario && @usuario_es_udip)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitud }
    end
  end
  
  
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

    #limpiamos fecha de creacion pasandola a formato MM/DD/YYYY
    @solicitud.fecha_creacion = fix_date(params[:solicitud][:fecha_creacion])
    
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
    @solicitud = Solicitud.find(params[:id])
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
    # si no se esta solicitando un filtro
    # solo mostramos las solicitudes de la institucion
    # del usuario actual
    params[:institucion_id] = usuario_actual.institucion_id unless (params[:filtrar] or usuario_actual_admin?)

    # guardamos el estado del filtro para agregarlo a la paginacion
    if params[:filtrar]
      @filtros = params
    else
      @filtros = nil
    end
        
    @solicitudes = Solicitud.buscar(params)
    

    @desde = ( params[:fecha_desde] ? Date.strptime(params[:fecha_desde], "%d/%m/%Y") : Date.today - Date.today.yday + 1 )
    @hasta = ( params[:fecha_hasta] ? Date.strptime(params[:fecha_hasta], "%d/%m/%Y") : Date.today )

  end

  private

  def get_institucion    
    @institucion = usuario_actual.institucion
  end

  def get_data
    @vias = Via.all
    @municipios = Departamento.first.municipios.all(:order => "municipios.nombre")
  end

  private
 


end

