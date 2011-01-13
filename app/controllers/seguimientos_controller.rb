class SeguimientosController < ApplicationController
  before_filter :get_data
  
  # GET /seguimientos/new
  # GET /seguimientos/new.xml
  def new
    @seguimiento = Seguimiento.new
  
    respond_to do |format|
      format.js # new.html.erb
    end
  end

  # POST /seguimientos
  # POST /seguimientos.xml
  def create
    @seguimiento = Seguimiento.new(params[:seguimiento])
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
    @seguimientos = Seguimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seguimientos }
    end
  end

  # GET /seguimientos/1
  # GET /seguimientos/1.xml
  def show
    @seguimiento = Seguimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seguimiento }
    end
  end

  
  # GET /seguimientos/1/edit
  def edit
    @seguimiento = Seguimiento.find(params[:id])
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
    @seguimiento = Seguimiento.find(params[:id])

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
    @seguimiento = Seguimiento.find(params[:id])
    @actividad = @seguimiento.actividad
    @seguimiento.destroy
    
    flash[:notice] = 'Seguimiento eliminado con exito.'
    respond_to do |format|
      format.js
    end
  end

  private

  def get_data
    @institucion = Institucion.find(params[:institucion_id]) if params[:institucion_id]
    @solicitud = Solicitud.find(params[:solicitud_id]) if params[:solicitud_id]
    @actividad = Actividad.find(params[:actividad_id]) if params[:actividad_id]
  end
end
