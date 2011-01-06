class EstadosController < ApplicationController
  # GET /estados
  # GET /estados.xml
  def index
    @estados = Estado.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estados }
    end
  end

  # GET /estados/1
  # GET /estados/1.xml
  def show
    @estado = Estado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estado }
    end
  end

  # GET /estados/new
  # GET /estados/new.xml
  def new
    @estado = Estado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estado }
    end
  end

  # GET /estados/1/edit
  def edit
    @estado = Estado.find(params[:id])
  end

  # POST /estados
  # POST /estados.xml
  def create
    @estado = Estado.new(params[:estado])

    respond_to do |format|
      if @estado.save
        flash[:notice] = 'Estado was successfully created.'
        format.html { redirect_to(@estado) }
        format.xml  { render :xml => @estado, :status => :created, :location => @estado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estados/1
  # PUT /estados/1.xml
  def update
    @estado = Estado.find(params[:id])

    respond_to do |format|
      if @estado.update_attributes(params[:estado])
        flash[:notice] = 'Estado was successfully updated.'
        format.html { redirect_to(@estado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estados/1
  # DELETE /estados/1.xml
  def destroy
    @estado = Estado.find(params[:id])
    @estado.destroy

    respond_to do |format|
      format.html { redirect_to(estados_url) }
      format.xml  { head :ok }
    end
  end
end
