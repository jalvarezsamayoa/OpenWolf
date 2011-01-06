class RazonestiposresolucionesController < ApplicationController
  # GET /razonestiposresoluciones
  # GET /razonestiposresoluciones.xml
  def index
    @razonestiposresoluciones = Razontiporesolucion.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @razonestiposresoluciones }
    end
  end

  # GET /razonestiposresoluciones/1
  # GET /razonestiposresoluciones/1.xml
  def show
    @razontiporesolucion = Razontiporesolucion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @razontiporesolucion }
    end
  end

  # GET /razonestiposresoluciones/new
  # GET /razonestiposresoluciones/new.xml
  def new
    @razontiporesolucion = Razontiporesolucion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @razontiporesolucion }
    end
  end

  # GET /razonestiposresoluciones/1/edit
  def edit
    @razontiporesolucion = Razontiporesolucion.find(params[:id])
  end

  # POST /razonestiposresoluciones
  # POST /razonestiposresoluciones.xml
  def create
    @razontiporesolucion = Razontiporesolucion.new(params[:razontiporesolucion])

    respond_to do |format|
      if @razontiporesolucion.save
        format.html { redirect_to(@razontiporesolucion, :notice => 'Razontiporesolucion was successfully created.') }
        format.xml  { render :xml => @razontiporesolucion, :status => :created, :location => @razontiporesolucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @razontiporesolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /razonestiposresoluciones/1
  # PUT /razonestiposresoluciones/1.xml
  def update
    @razontiporesolucion = Razontiporesolucion.find(params[:id])

    respond_to do |format|
      if @razontiporesolucion.update_attributes(params[:razontiporesolucion])
        format.html { redirect_to(@razontiporesolucion, :notice => 'Razontiporesolucion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @razontiporesolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /razonestiposresoluciones/1
  # DELETE /razonestiposresoluciones/1.xml
  def destroy
    @razontiporesolucion = Razontiporesolucion.find(params[:id])
    @razontiporesolucion.destroy

    respond_to do |format|
      format.html { redirect_to(razonestiposresoluciones_url) }
      format.xml  { head :ok }
    end
  end
end
