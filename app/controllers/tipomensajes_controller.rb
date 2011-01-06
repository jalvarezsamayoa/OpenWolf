class TipomensajesController < ApplicationController
  before_filter :requiere_usuario
  access_control do
    allow :superadmin
  end
  
  # GET /tipomensajes
  # GET /tipomensajes.xml
  def index
    @tipomensajes = Tipomensaje.nombre_like(params[:search]).paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipomensajes }
    end
  end

  # GET /tipomensajes/1
  # GET /tipomensajes/1.xml
  def show
    @tipomensaje = Tipomensaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipomensaje }
    end
  end

  # GET /tipomensajes/new
  # GET /tipomensajes/new.xml
  def new
    @tipomensaje = Tipomensaje.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipomensaje }
    end
  end

  # GET /tipomensajes/1/edit
  def edit
    @tipomensaje = Tipomensaje.find(params[:id])
  end

  # POST /tipomensajes
  # POST /tipomensajes.xml
  def create
    @tipomensaje = Tipomensaje.new(params[:tipomensaje])

    respond_to do |format|
      if @tipomensaje.save
        flash[:notice] = 'Tipomensaje was successfully created.'
        format.html { redirect_to(@tipomensaje) }
        format.xml  { render :xml => @tipomensaje, :status => :created, :location => @tipomensaje }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipomensaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipomensajes/1
  # PUT /tipomensajes/1.xml
  def update
    @tipomensaje = Tipomensaje.find(params[:id])

    respond_to do |format|
      if @tipomensaje.update_attributes(params[:tipomensaje])
        flash[:notice] = 'Tipomensaje was successfully updated.'
        format.html { redirect_to(@tipomensaje) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipomensaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipomensajes/1
  # DELETE /tipomensajes/1.xml
  def destroy
    @tipomensaje = Tipomensaje.find(params[:id])
    @tipomensaje.destroy

    respond_to do |format|
      format.html { redirect_to(tipomensajes_url) }
      format.xml  { head :ok }
    end
  end
end
