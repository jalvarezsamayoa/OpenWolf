class FuentesController < ApplicationController
  # GET /fuentes
  # GET /fuentes.xml
  def index
    @fuentes = Fuente.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fuentes }
    end
  end

  # GET /fuentes/1
  # GET /fuentes/1.xml
  def show
    @fuente = Fuente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fuente }
    end
  end

  # GET /fuentes/new
  # GET /fuentes/new.xml
  def new
    @fuente = Fuente.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fuente }
    end
  end

  # GET /fuentes/1/edit
  def edit
    @fuente = Fuente.find(params[:id])
  end

  # POST /fuentes
  # POST /fuentes.xml
  def create
    @fuente = Fuente.new(params[:fuente])

    respond_to do |format|
      if @fuente.save
        flash[:notice] = 'Fuente was successfully created.'
        format.html { redirect_to(@fuente) }
        format.xml  { render :xml => @fuente, :status => :created, :location => @fuente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fuente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fuentes/1
  # PUT /fuentes/1.xml
  def update
    @fuente = Fuente.find(params[:id])

    respond_to do |format|
      if @fuente.update_attributes(params[:fuente])
        flash[:notice] = 'Fuente was successfully updated.'
        format.html { redirect_to(@fuente) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fuente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fuentes/1
  # DELETE /fuentes/1.xml
  def destroy
    @fuente = Fuente.find(params[:id])
    @fuente.destroy

    respond_to do |format|
      format.html { redirect_to(fuentes_url) }
      format.xml  { head :ok }
    end
  end
end
