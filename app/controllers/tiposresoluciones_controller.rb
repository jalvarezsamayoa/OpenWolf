class TiposresolucionesController < ApplicationController
  # GET /tiposresoluciones
  # GET /tiposresoluciones.xml
  def index
    @tiposresoluciones = Tiporesolucion.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposresoluciones }
    end
  end

  # GET /tiposresoluciones/1
  # GET /tiposresoluciones/1.xml
  def show
    @tiporesolucion = Tiporesolucion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiporesolucion }
    end
  end

  # GET /tiposresoluciones/new
  # GET /tiposresoluciones/new.xml
  def new
    @tiporesolucion = Tiporesolucion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiporesolucion }
    end
  end

  # GET /tiposresoluciones/1/edit
  def edit
    @tiporesolucion = Tiporesolucion.find(params[:id])
  end

  # POST /tiposresoluciones
  # POST /tiposresoluciones.xml
  def create
    @tiporesolucion = Tiporesolucion.new(params[:tiporesolucion])

    respond_to do |format|
      if @tiporesolucion.save
        format.html { redirect_to(@tiporesolucion, :notice => 'Tiporesolucion was successfully created.') }
        format.xml  { render :xml => @tiporesolucion, :status => :created, :location => @tiporesolucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiporesolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposresoluciones/1
  # PUT /tiposresoluciones/1.xml
  def update
    @tiporesolucion = Tiporesolucion.find(params[:id])

    respond_to do |format|
      if @tiporesolucion.update_attributes(params[:tiporesolucion])
        format.html { redirect_to(@tiporesolucion, :notice => 'Tiporesolucion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiporesolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposresoluciones/1
  # DELETE /tiposresoluciones/1.xml
  def destroy
    @tiporesolucion = Tiporesolucion.find(params[:id])
    @tiporesolucion.destroy

    respond_to do |format|
      format.html { redirect_to(tiposresoluciones_url) }
      format.xml  { head :ok }
    end
  end
end
