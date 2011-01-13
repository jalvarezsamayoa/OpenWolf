class IdiomasController < ApplicationController
  # GET /idiomas
  # GET /idiomas.xml
  def index
    @idiomas = Idioma.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @idiomas }
    end
  end

  # GET /idiomas/1
  # GET /idiomas/1.xml
  def show
    @idioma = Idioma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @idioma }
    end
  end

  # GET /idiomas/new
  # GET /idiomas/new.xml
  def new
    @idioma = Idioma.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @idioma }
    end
  end

  # GET /idiomas/1/edit
  def edit
    @idioma = Idioma.find(params[:id])
  end

  # POST /idiomas
  # POST /idiomas.xml
  def create
    @idioma = Idioma.new(params[:idioma])

    respond_to do |format|
      if @idioma.save
        format.html { redirect_to(@idioma, :notice => 'Idioma creado con exito.') }
        format.xml  { render :xml => @idioma, :status => :created, :location => @idioma }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @idioma.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /idiomas/1
  # PUT /idiomas/1.xml
  def update
    @idioma = Idioma.find(params[:id])

    respond_to do |format|
      if @idioma.update_attributes(params[:idioma])
        format.html { redirect_to(@idioma, :notice => 'Idioma actualizado con exito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @idioma.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /idiomas/1
  # DELETE /idiomas/1.xml
  def destroy
    @idioma = Idioma.find(params[:id])
    @idioma.destroy

    respond_to do |format|
      format.html { redirect_to(idiomas_url) }
      format.xml  { head :ok }
    end
  end
end
