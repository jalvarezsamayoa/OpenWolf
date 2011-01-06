class ProfesionesController < ApplicationController
  # GET /profesiones
  # GET /profesiones.xml
  def index
    @profesiones = Profesion.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profesiones }
    end
  end

  # GET /profesiones/1
  # GET /profesiones/1.xml
  def show
    @profesion = Profesion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profesion }
    end
  end

  # GET /profesiones/new
  # GET /profesiones/new.xml
  def new
    @profesion = Profesion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profesion }
    end
  end

  # GET /profesiones/1/edit
  def edit
    @profesion = Profesion.find(params[:id])
  end

  # POST /profesiones
  # POST /profesiones.xml
  def create
    @profesion = Profesion.new(params[:profesion])

    respond_to do |format|
      if @profesion.save
        format.html { redirect_to(@profesion, :notice => 'Profesion was successfully created.') }
        format.xml  { render :xml => @profesion, :status => :created, :location => @profesion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profesion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profesiones/1
  # PUT /profesiones/1.xml
  def update
    @profesion = Profesion.find(params[:id])

    respond_to do |format|
      if @profesion.update_attributes(params[:profesion])
        format.html { redirect_to(@profesion, :notice => 'Profesion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profesion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profesiones/1
  # DELETE /profesiones/1.xml
  def destroy
    @profesion = Profesion.find(params[:id])
    @profesion.destroy

    respond_to do |format|
      format.html { redirect_to(profesiones_url) }
      format.xml  { head :ok }
    end
  end
end
