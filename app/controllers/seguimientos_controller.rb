class SeguimientosController < ApplicationController
  before_filter :get_data

  # GET /seguimientos/new
  # GET /seguimientos/new.xml
  def new
    @seguimiento = @institucion.seguimientos.new

    respond_to do |format|
      format.js # new.html.erb
    end
  end

  # POST /seguimientos
  # POST /seguimientos.xml
  def create
    @seguimiento = @institucion.seguimientos.new(params[:seguimiento])
    @seguimiento.usuario_id = usuario_actual.id
    @seguimiento.actividad = @actividad
    @dom_id = "#seguimientos_actividad_"+@seguimiento.actividad_id.to_s
    respond_to do |format|
      if @seguimiento.save
        flash[:success] = 'Seguimiento grabado con exito.'
        format.js
      else
        flash[:error] = 'No fue posible grabar seguimiento.'
        format.js
      end
    end
  end


  # GET /seguimientos
  # GET /seguimientos.xml
  def index
    @seguimientos = @institucion.seguimientos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seguimientos }
    end
  end

  # GET /seguimientos/1
  # GET /seguimientos/1.xml
  def show
    @seguimiento = @institucion.seguimientos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seguimiento }
    end
  end


  # GET /seguimientos/1/edit
  def edit
    @seguimiento = @institucion.seguimientos.find(params[:id])
    @actividad = @seguimiento.actividad
    @solicitud = @actividad.solicitud
    @institucion = @solicitud.institucion

    respond_to do |format|
      format.js # new.html.erb
    end
  end


  # PUT /seguimientos/1
  # PUT /seguimientos/1.xml
  def update
    @seguimiento = @institucion.seguimientos.find(params[:id])
    @actividad = @seguimiento.actividad

    @dom_id = "#seguimientos_actividad_"+@seguimiento.actividad_id.to_s

    respond_to do |format|
      if @seguimiento.update_attributes(params[:seguimiento])
        flash[:notice] = 'Seguimiento actualizado con exito.'
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /seguimientos/1
  # DELETE /seguimientos/1.xml
  def destroy
    @seguimiento = @institucion.seguimientos.find(params[:id])
    @actividad = @seguimiento.actividad
    @seguimiento.destroy

    flash[:notice] = 'Seguimiento eliminado con exito.'
    respond_to do |format|
      format.js
    end
  end

  private

  def get_data
    @institucion = current_user.institucion

    begin
      @solicitud = @institucion.solicitudes.find(params[:solicitud_id]) if params[:solicitud_id]
      @actividad = @institucion.actividades.find(params[:actividad_id]) if params[:actividad_id]
    rescue
      @solicitud = nil
      @actividad = nil
    end

    # si no se encontro datos verificamos si es una asignacion inter
    # institucional
    if current_user.has_role?(:superudip)
      @solicitud = Solicitud.find(params[:solicitud_id]) if params[:solicitud_id]
      @actividad = Actividad.find(params[:actividad_id]) if params[:actividad_id]
    end


  end
end
