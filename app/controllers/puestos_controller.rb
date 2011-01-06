class PuestosController < ApplicationController
  before_filter :requiere_usuario
  before_filter :get_data
  # GET /puestos
  # GET /puestos.xml
  def index
    @puestos = Puesto.paginate :page=>params[:page], :per_page=>10, :include => :institucion, :order => "instituciones.nombre, puestos.nombre"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @puestos }
    end
  end

  # GET /puestos/1
  # GET /puestos/1.xml
  def show
    @puesto = Puesto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @puesto }
    end
  end

  # GET /puestos/new
  # GET /puestos/new.xml
  def new
    @puesto = Puesto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @puesto }
    end
  end

  # GET /puestos/1/edit
  def edit
    @puesto = Puesto.find(params[:id])
  end

  # POST /puestos
  # POST /puestos.xml
  def create
    @puesto = Puesto.new(params[:puesto])

    respond_to do |format|
      if @puesto.save
        flash[:notice] = 'Puesto was successfully created.'
        format.html { redirect_to(@puesto) }
        format.xml  { render :xml => @puesto, :status => :created, :location => @puesto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @puesto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /puestos/1
  # PUT /puestos/1.xml
  def update
    @puesto = Puesto.find(params[:id])

    respond_to do |format|
      if @puesto.update_attributes(params[:puesto])
        flash[:notice] = 'Puesto was successfully updated.'
        format.html { redirect_to(@puesto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @puesto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /puestos/1
  # DELETE /puestos/1.xml
  def destroy
    @puesto = Puesto.find(params[:id])
    @puesto.destroy

    respond_to do |format|
      format.html { redirect_to(puestos_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_data
    @instituciones = Institucion.all(:order => "nombre")
  end
end
