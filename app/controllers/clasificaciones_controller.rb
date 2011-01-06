class ClasificacionesController < ApplicationController
  # GET /clasificaciones
  # GET /clasificaciones.xml
  def index
    @clasificaciones = Clasificacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clasificaciones }
    end
  end

  # GET /clasificaciones/1
  # GET /clasificaciones/1.xml
  def show
    @clasificacion = Clasificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clasificacion }
    end
  end

  # GET /clasificaciones/new
  # GET /clasificaciones/new.xml
  def new
    @clasificacion = Clasificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @clasificacion }
    end
  end

  # GET /clasificaciones/1/edit
  def edit
    @clasificacion = Clasificacion.find(params[:id])
  end

  # POST /clasificaciones
  # POST /clasificaciones.xml
  def create
    @clasificacion = Clasificacion.new(params[:clasificacion])

    respond_to do |format|
      if @clasificacion.save
        format.html { redirect_to(@clasificacion, :notice => 'Clasificacion was successfully created.') }
        format.xml  { render :xml => @clasificacion, :status => :created, :location => @clasificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @clasificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clasificaciones/1
  # PUT /clasificaciones/1.xml
  def update
    @clasificacion = Clasificacion.find(params[:id])

    respond_to do |format|
      if @clasificacion.update_attributes(params[:clasificacion])
        format.html { redirect_to(@clasificacion, :notice => 'Clasificacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clasificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clasificaciones/1
  # DELETE /clasificaciones/1.xml
  def destroy
    @clasificacion = Clasificacion.find(params[:id])
    @clasificacion.destroy

    respond_to do |format|
      format.html { redirect_to(clasificaciones_url) }
      format.xml  { head :ok }
    end
  end
end
