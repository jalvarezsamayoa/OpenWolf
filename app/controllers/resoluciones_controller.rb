class ResolucionesController < ApplicationController
  before_filter :get_solicitud, :except => [:actualizar_razones]
  before_filter :obtener_privilegios, :only => [:new, :edit]
  
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
    
    @resolucion.fecha = l(Date.today)
    @resolucion.fecha_notificacion = l(Date.today)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /resoluciones/1/edit
  def edit
    @resolucion = @solicitud.resoluciones.find(params[:id])
    @resolucion.fecha = l(@resolucion.fecha) if @resolucion.fecha.class == Date
    @resolucion.fecha_notificacion = l(@resolucion.fecha_notificacion) if @resolucion.fecha_notificacion.class == Date
    @resolucion.nueva_fecha = l(@resolucion.nueva_fecha) if @resolucion.nueva_fecha.class == Date
  end

  # POST /resoluciones
  # POST /resoluciones.xml
  def create

    @resolucion = @solicitud.resoluciones.new(params[:resolucion])
    @resolucion.institucion_id = current_user.institucion_id
    @resolucion.solicitud_id = @solicitud.id
    @resolucion.usuario_id = current_user.id

    if params[:resolucion][:fecha]
     #limpiamos fecha de creacion pasandola a formato MM/DD/YYYY
      @resolucion.fecha = fix_date(params[:resolucion][:fecha])
    end

     if params[:resolucion][:fecha_notificacion]
     #limpiamos fecha de creacion pasandola a formato MM/DD/YYYY
      @resolucion.fecha_notificacion = fix_date(params[:resolucion][:fecha_notificacion])
     end

     @resolucion.nueva_fecha = fix_date(params[:resolucion][:nueva_fecha]) if params[:resolucion][:nueva_fecha]
   

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
     
    #limpiamos fecha de creacion pasandola a formato MM/DD/YYYY
    params[:resolucion][:fecha] = fix_date(params[:resolucion][:fecha]) if params[:resolucion][:fecha]
    params[:resolucion][:fecha_notificacion] = fix_date(params[:resolucion][:fecha_notificacion]) if params[:resolucion][:fecha_notificacion]
    params[:resolucion][:nueva_fecha] = fix_date(params[:resolucion][:nueva_fecha]) if params[:resolucion][:nueva_fecha]
   

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

    # si una solicitud no esta termindada? = 100%
    # solo se pueden emitir prorrogas
    
    if @solicitud.terminada?
      @tiposresoluciones = Tiporesolucion.all
      @razones = Tiporesolucion.first.razonestiposresoluciones.all(:order => "razonestiposresoluciones.nombre")
    else
      @tiposresoluciones = Tiporesolucion.prorroga
      @razones = @tiposresoluciones.first.razonestiposresoluciones.all(:order => "razonestiposresoluciones.nombre")
    end
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

  def obtener_privilegios
    @es_pertinente_a_usuario = @solicitud.es_pertinente?(usuario_actual)
    @usuario_es_supervisor =  nivel_seguridad(usuario_actual,'encargadoudip')
    @puede_modificar_fecha = (@es_pertinente_a_usuario && @usuario_es_supervisor)
  end
    
end
