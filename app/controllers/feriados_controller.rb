class FeriadosController < ApplicationController
  before_filter :requiere_usuario
  
  # GET /feriados
  # GET /feriados.xml
  def index
    @feriados = Feriado.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feriados }
    end
  end

  # GET /feriados/1
  # GET /feriados/1.xml
  def show
    @feriado = Feriado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feriado }
    end
  end

  # GET /feriados/new
  # GET /feriados/new.xml
  def new
    @feriado = Feriado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feriado }
    end
  end

  # GET /feriados/1/edit
  def edit
    @feriado = Feriado.find(params[:id])
  end

  # POST /feriados
  # POST /feriados.xml
  def create
    @feriado = Feriado.new(params[:feriado])

    respond_to do |format|
      if @feriado.save
        format.html { redirect_to(@feriado, :notice => 'Feriado creado con exito.') }
        format.xml  { render :xml => @feriado, :status => :created, :location => @feriado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feriado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feriados/1
  # PUT /feriados/1.xml
  def update
    @feriado = Feriado.find(params[:id])

    respond_to do |format|
      if @feriado.update_attributes(params[:feriado])
        format.html { redirect_to(@feriado, :notice => 'Feriado actualizado con exito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feriado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feriados/1
  # DELETE /feriados/1.xml
  def destroy
    @feriado = Feriado.find(params[:id])
    @feriado.destroy

    respond_to do |format|
      format.html { redirect_to(feriados_url) }
      format.xml  { head :ok }
    end
  end
end
