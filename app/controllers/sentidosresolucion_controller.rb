class SentidosresolucionController < ApplicationController
  # GET /sentidosresolucion
  # GET /sentidosresolucion.xml
  def index
    @sentidosresolucion = Sentidoresolucion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sentidosresolucion }
    end
  end

  # GET /sentidosresolucion/1
  # GET /sentidosresolucion/1.xml
  def show
    @sentidoresolucion = Sentidoresolucion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sentidoresolucion }
    end
  end

  # GET /sentidosresolucion/new
  # GET /sentidosresolucion/new.xml
  def new
    @sentidoresolucion = Sentidoresolucion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sentidoresolucion }
    end
  end

  # GET /sentidosresolucion/1/edit
  def edit
    @sentidoresolucion = Sentidoresolucion.find(params[:id])
  end

  # POST /sentidosresolucion
  # POST /sentidosresolucion.xml
  def create
    @sentidoresolucion = Sentidoresolucion.new(params[:sentidoresolucion])

    respond_to do |format|
      if @sentidoresolucion.save
        format.html { redirect_to(@sentidoresolucion, :notice => 'Sentidoresolucion was successfully created.') }
        format.xml  { render :xml => @sentidoresolucion, :status => :created, :location => @sentidoresolucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sentidoresolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sentidosresolucion/1
  # PUT /sentidosresolucion/1.xml
  def update
    @sentidoresolucion = Sentidoresolucion.find(params[:id])

    respond_to do |format|
      if @sentidoresolucion.update_attributes(params[:sentidoresolucion])
        format.html { redirect_to(@sentidoresolucion, :notice => 'Sentidoresolucion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sentidoresolucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sentidosresolucion/1
  # DELETE /sentidosresolucion/1.xml
  def destroy
    @sentidoresolucion = Sentidoresolucion.find(params[:id])
    @sentidoresolucion.destroy

    respond_to do |format|
      format.html { redirect_to(sentidosresolucion_url) }
      format.xml  { head :ok }
    end
  end
end
