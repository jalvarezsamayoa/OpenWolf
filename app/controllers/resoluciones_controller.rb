class ResolucionesController < ApplicationController
  before_filter :get_solicitud, :except => [:actualizar_razones]
  
  access_control do
    allow :superudip
    allow :userudip
  end

  def index
    @resoluciones = @solicitud.resoluciones
  end

  def show
    @resolucion = @solicitud.resoluciones.find(params[:id])
  end
  
  # GET /resoluciones/new
  # GET /resoluciones/new.xml
  def new
    @resolucion = @solicitud.resoluciones.new
    @resolucion.numero = ''
    @resolucion.solicitud_id = @solicitud.id
    @resolucion.usuario_id = current_user.id
    @resolucion.institucion_id = current_user.institucion_id
    @resolucion.descripcion = 'No Disponible'
    @resolucion.numero = @resolucion.nuevo_numero

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /resoluciones/1/edit
  def edit
    @resolucion = @solicitud.resoluciones.find(params[:id])
  end

  # POST /resoluciones
  # POST /resoluciones.xml
  def create
    @resolucion = @solicitud.resoluciones.new(params[:resolucion])
    @resolucion.institucion_id = current_user.institucion_id
    @resolucion.solicitud_id = @solicitud.id
    @resolucion.usuario_id = current_user.id
    

    respond_to do |format|
      if @resolucion.save
        format.html { redirect_to([@solicitud,@resolucion], :notice => 'Resolucion creada con exito.') }
        format.xml  { render :xml => @resolucion, :status => :created, :location => @resolucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resoluciones/1
  # PUT /resoluciones/1.xml
  def update
    @resolucion = @solicitud.resoluciones.find(params[:id])

    respond_to do |format|
      if @resolucion.update_attributes(params[:resolucion])
        format.html { redirect_to([@solicitud,@resolucion], :notice => 'Resolucion actualizada con exito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resoluciones/1
  # DELETE /resoluciones/1.xml
  def destroy
    @resolucion = @solicitud.resoluciones.find(params[:id])
    @resolucion.destroy

    respond_to do |format|
      format.html { redirect_to(solicitud_resoluciones_url(@solicitud), :notice => 'Resolucion eliminada con exito.' ) }
      format.xml  { head :ok }
    end
  end

  def get_solicitud
    @solicitud = Solicitud.find(params[:solicitud_id])
    @razones = Tiporesolucion.first.razonestiposresoluciones.all(:order => "razonestiposresoluciones.nombre")
  end

  def actualizar_razones
    @tiporesolucion = Tiporesolucion.find(params[:tiporesolucion_id])
    @razones = @tiporesolucion.razonestiposresoluciones
    respond_to do |format|
      format.js do
        render :actualizar_razones
      end
    end
  end
  
end
