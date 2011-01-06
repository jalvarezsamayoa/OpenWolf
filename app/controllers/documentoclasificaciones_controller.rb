class DocumentoclasificacionesController < ApplicationController
  before_filter :requiere_usuario
  access_control do
    allow :superadmin
  end
  
  # GET /documentoclasificaciones
  # GET /documentoclasificaciones.xml
  def index
    @documentoclasificaciones = Documentoclasificacion.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documentoclasificaciones }
    end
  end

  # GET /documentoclasificaciones/1
  # GET /documentoclasificaciones/1.xml
  def show
    @documentoclasificacion = Documentoclasificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documentoclasificacion }
    end
  end

  # GET /documentoclasificaciones/new
  # GET /documentoclasificaciones/new.xml
  def new
    @documentoclasificacion = Documentoclasificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @documentoclasificacion }
    end
  end

  # GET /documentoclasificaciones/1/edit
  def edit
    @documentoclasificacion = Documentoclasificacion.find(params[:id])
  end

  # POST /documentoclasificaciones
  # POST /documentoclasificaciones.xml
  def create
    @documentoclasificacion = Documentoclasificacion.new(params[:documentoclasificacion])

    respond_to do |format|
      if @documentoclasificacion.save
        format.html { redirect_to(@documentoclasificacion, :notice => 'Documentoclasificacion was successfully created.') }
        format.xml  { render :xml => @documentoclasificacion, :status => :created, :location => @documentoclasificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @documentoclasificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documentoclasificaciones/1
  # PUT /documentoclasificaciones/1.xml
  def update
    @documentoclasificacion = Documentoclasificacion.find(params[:id])

    respond_to do |format|
      if @documentoclasificacion.update_attributes(params[:documentoclasificacion])
        format.html { redirect_to(@documentoclasificacion, :notice => 'Documentoclasificacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @documentoclasificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documentoclasificaciones/1
  # DELETE /documentoclasificaciones/1.xml
  def destroy
    @documentoclasificacion = Documentoclasificacion.find(params[:id])
    @documentoclasificacion.destroy

    respond_to do |format|
      format.html { redirect_to(documentoclasificaciones_url) }
      format.xml  { head :ok }
    end
  end
end
