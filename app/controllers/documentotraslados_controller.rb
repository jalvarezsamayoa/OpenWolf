class DocumentotrasladosController < ApplicationController
  # GET /documentotraslados
  # GET /documentotraslados.xml
  def index
    @documentotraslados = Documentotraslado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documentotraslados }
    end
  end

  # GET /documentotraslados/1
  # GET /documentotraslados/1.xml
  def show
    @documentotraslado = Documentotraslado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documentotraslado }
    end
  end

  # GET /documentotraslados/new
  # GET /documentotraslados/new.xml
  def new
    @documentotraslado = Documentotraslado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @documentotraslado }
    end
  end

  # GET /documentotraslados/1/edit
  def edit
    @documentotraslado = Documentotraslado.find(params[:id])
  end

  # POST /documentotraslados
  # POST /documentotraslados.xml
  def create
    @documentotraslado = Documentotraslado.new(params[:documentotraslado])
    @documentotraslado.usuario_id = usuario_actual.id
    @documentotraslado.institucion_id = usuario_actual.institucion_id
    @documentotraslado.estado_entrega_id = 1
    @documentotraslado.fecha_envio = Date.today
    
    @documento = @documentotraslado.documento
    

    respond_to do |format|
      if @documentotraslado.save
        format.html { redirect_to(@documento, :notice => 'Documento trasladado con exito.') }
        format.xml  { render :xml => @documentotraslado, :status => :created, :location => @documentotraslado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @documentotraslado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documentotraslados/1
  # PUT /documentotraslados/1.xml
  def update
    @documentotraslado = Documentotraslado.find(params[:id])

    respond_to do |format|
      if @documentotraslado.update_attributes(params[:documentotraslado])
        format.html { redirect_to(@documentotraslado, :notice => 'Documentotraslado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @documentotraslado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documentotraslados/1
  # DELETE /documentotraslados/1.xml
  def destroy
    @documentotraslado = Documentotraslado.find(params[:id])
    @documentotraslado.destroy

    respond_to do |format|
      format.html { redirect_to(documentotraslados_url) }
      format.xml  { head :ok }
    end
  end
end
