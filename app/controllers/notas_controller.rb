class NotasController < ApplicationController
  before_filter :requiere_usuario
  before_filter :get_solicitud
  
  # GET /notas
  # GET /notas.xml
  def index
    @notas = @solicitud.notas.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notas }
    end
  end

  # GET /notas/1
  # GET /notas/1.xml
  def show
    @nota = @solicitud.notas.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nota }
    end
  end

  # GET /notas/new
  # GET /notas/new.xml
  def new
    @nota = @solicitud.notas.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nota }
    end
  end

  # GET /notas/1/edit
  def edit
    @nota = @solicitud.notas.find(params[:id])
  end

  # POST /notas
  # POST /notas.xml
  def create
    params[:nota][:usuario_id] = usuario_actual.id
    @nota = @solicitud.notas.new(params[:nota])

    respond_to do |format|
      if @nota.save
        format.html { redirect_to( solicitud_notas_path(@solicitud), :notice => 'Seguimiento agregado con exito.') }
        format.xml  { render :xml => @nota, :status => :created, :location => @nota }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nota.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notas/1
  # PUT /notas/1.xml
  def update
    @nota = @solicitud.notas.find(params[:id])

    respond_to do |format|
      if @nota.update_attributes(params[:nota])
        format.html { redirect_to( solicitud_notas_path(@solicitud), :notice => 'Seguimiento actualizado con exito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nota.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notas/1
  # DELETE /notas/1.xml
  def destroy
    @nota = @solicitud.notas.find(params[:id])
    @nota.destroy

    respond_to do |format|
      format.html { redirect_to(solicitud_notas_url(@solicitud)) }
      format.xml  { head :ok }
    end
  end

  private

  def get_solicitud
    @solicitud = Solicitud.find(params[:solicitud_id])
  end
end
