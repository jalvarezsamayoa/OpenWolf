class ActividadesController < ApplicationController
  before_filter :requiere_usuario
  before_filter :get_data, :except =>[:marcar_como_completada, :index, :actualizar_usuarios]

  def index
    @asignaciones = usuario_actual.actividades
  end

  def show
    @actividad = Actividad.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  # GET /actividades/new
  # GET /actividades/new.xml
  def new
    @actividad = usuario_actual.institucion.actividades.new
    @instituciones = usuario_actual.institucion.familia

    respond_to do |format|
      format.js
    end
  end

  # GET /actividades/1/edit
  def edit
    @actividad = Actividad.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  # POST /actividades
  # POST /actividades.xml
  def create
    @actividad = Actividad.new(params[:actividad])
    @actividad.solicitud_id = @solicitud.id
    @actividades = @solicitud.actividades
    
    respond_to do |format|
      if @actividad.save
        flash[:success] = 'Asignacion creada con exito.'
        format.js
      else
        @actividad.institucion_id = current_user.institucion_id
        @instituciones = usuario_actual.institucion.familia
        @usuarios = @institucion.usuarios.enlaces
        
        flash[:error] = 'Asignacion fallida.'
        format.js do
          render :failed
        end
      end
    end
  end

  # PUT /actividades/1
  # PUT /actividades/1.xml
  def update
    @actividad = Actividad.find(params[:id])

    respond_to do |format|
      if @actividad.update_attributes(params[:actividad])
        flash[:notice] = 'Actividad was successfully updated.'
        format.html { redirect_to(@actividad) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @actividad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /actividades/1
  # DELETE /actividades/1.xml
  def destroy
    @actividad = Actividad.find(params[:id])
    @actividad.destroy

    respond_to do |format|
      format.html { redirect_to(institucion_solicitud_url(@institucion,@solicitud)) }
      format.xml  { head :ok }
    end
  end

  #cambia estado de actividad
  def marcar_como_completada
    @actividad = Actividad.find(params[:id])
    
    respond_to do |format|
      if @actividad.marcar_como_terminada
        flash[:success] = 'Asignacion marcada como Completada.'
        
      else
        flash[:error] = 'Asignacion no pudo ser actualizada'
      end

      @asignaciones = usuario_actual.actividades.nocompletadas
      
      format.html { redirect_to solicitudes_path }
    end    
  end

  def actualizar_usuarios
    institucion = Institucion.find(params[:institucion_id])
    if institucion.id == usuario_actual.institucion_id
      @usuarios = institucion.usuarios
    else
      @usuarios = institucion.usuarios.supervisores
    end
     respond_to do |format|
      format.js do
        render :actualizar_usuarios
      end
    end
  end

  private

  def get_data
    @institucion = usuario_actual.institucion
    @solicitud = Solicitud.find(params[:solicitud_id])
    @usuarios = @institucion.usuarios.enlaces
  end
end
