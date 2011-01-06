class MensajesController < ApplicationController
  before_filter :get_data
  # GET /mensajes
  # GET /mensajes.xml
  def index
    @mensajes = @institucion.mensajes

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mensajes }
    end
  end

  # GET /mensajes/1
  # GET /mensajes/1.xml
  def show
    @mensaje = Mensaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mensaje }
    end
  end

  # GET /mensajes/new
  # GET /mensajes/new.xml
  def new
    @mensaje = Mensaje.new
    @mensaje.fecha_recepcion = l(Date.today)
    @mensaje.fecha_documento = l(Date.today)
    @mensaje.telefonos = 'No Disponible'
    @mensaje.direccion = 'No Disponible'
    @mensaje.observaciones = 'No Disponible'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mensaje }
    end
  end

  # GET /mensajes/1/edit
  def edit
    @mensaje = Mensaje.find(params[:id])
  end

  # POST /mensajes
  # POST /mensajes.xml
  def create
    @mensaje = Mensaje.new(params[:mensaje])

    @mensaje.usuario_id = usuario_actual.id
    @mensaje.institucion_id = @institucion.id

    respond_to do |format|
      if @mensaje.save
        flash[:notice] = 'Mensaje fue grabado con exito.'
        format.html { redirect_to institucion_mensaje_path(@institucion, @mensaje) }
        format.xml  { render :xml => @mensaje, :status => :created, :location => @mensaje }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mensaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mensajes/1
  # PUT /mensajes/1.xml
  def update
    @mensaje = Mensaje.find(params[:id])

    respond_to do |format|
      if @mensaje.update_attributes(params[:mensaje])
        flash[:notice] = 'Mensaje fue actualizado con exito.'
        format.html { redirect_to(@mensaje) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mensaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mensajes/1
  # DELETE /mensajes/1.xml
  def destroy
    @mensaje = Mensaje.find(params[:id])
    @mensaje.destroy

    respond_to do |format|
      format.html { redirect_to(mensajes_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_data
    @institucion = usuario_actual.institucion
  end
end
