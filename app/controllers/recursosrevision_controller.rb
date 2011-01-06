class RecursosrevisionController < ApplicationController
  before_filter :get_solicitud
  
  # GET /recursosrevision/1
  # GET /recursosrevision/1.xml
  def show
    @recursorevision = @solicitud.recursorevision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recursorevision }
    end
  end

  # GET /recursosrevision/new
  # GET /recursosrevision/new.xml
  def new
    @recursorevision = Recursorevision.new    
    @recursorevision.solicitud_id = @solicitud.id
    @recursorevision.institucion_id = @solicitud.institucion_id
    @recursorevision.usuario_id = usuario_actual.id
    @recursorevision.descripcion = 'No Disponible'
    @recursorevision.numero = @recursorevision.nuevo_numero
    @recursorevision.fecha_presentacion = Date.today
    @recursorevision.fecha_notificacion = Date.today
    @recursorevision.fecha_resolucion = Date.today
    
    
    respond_to do |format|
      format.js
    end
    
  end

  # GET /recursosrevision/1/edit
  def edit
    @recursorevision = Recursorevision.find(params[:id])
  end

  # POST /recursosrevision
  # POST /recursosrevision.xml
  def create
    @recursorevision = Recursorevision.new(params[:recursorevision])
    @recursorevision.institucion_id = current_user.institucion_id
    @recursorevision.solicitud_id = @solicitud.id
    @recursorevision.usuario_id = current_user.id

    respond_to do |format|
      if @recursorevision.save
        format.html { redirect_to(@solicitud, :notice => 'Recurso revision creado con exito.') }
        format.xml  { render :xml => @recursorevision, :status => :created, :location => @recursorevision }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recursorevision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recursosrevision/1
  # PUT /recursosrevision/1.xml
  def update
    @recursorevision = Recursorevision.find(params[:id])

    respond_to do |format|
      if @recursorevision.update_attributes(params[:recursorevision])
        format.html { redirect_to(@solicitud, :notice => 'Recurso revision actualizado con exito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recursorevision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recursosrevision/1
  # DELETE /recursosrevision/1.xml
  def destroy
    @recursorevision = Recursorevision.find(params[:id])
    @recursorevision.destroy

    respond_to do |format|
      format.html { redirect_to(recursosrevision_url) }
      format.xml  { head :ok }
    end
  end

  def get_solicitud
    #TODO: filtrar por institucion
    @solicitud = Solicitud.find(params[:solicitud_id])   
  end
end
