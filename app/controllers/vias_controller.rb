class ViasController < ApplicationController
  # GET /vias
  # GET /vias.xml
  def index
    @vias = Via.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vias }
    end
  end

  # GET /vias/1
  # GET /vias/1.xml
  def show
    @via = Via.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @via }
    end
  end

  # GET /vias/new
  # GET /vias/new.xml
  def new
    @via = Via.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @via }
    end
  end

  # GET /vias/1/edit
  def edit
    @via = Via.find(params[:id])
  end

  # POST /vias
  # POST /vias.xml
  def create
    @via = Via.new(params[:via])

    respond_to do |format|
      if @via.save
        flash[:notice] = 'Via was successfully created.'
        format.html { redirect_to(@via) }
        format.xml  { render :xml => @via, :status => :created, :location => @via }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @via.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vias/1
  # PUT /vias/1.xml
  def update
    @via = Via.find(params[:id])

    respond_to do |format|
      if @via.update_attributes(params[:via])
        flash[:notice] = 'Via was successfully updated.'
        format.html { redirect_to(@via) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @via.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vias/1
  # DELETE /vias/1.xml
  def destroy
    @via = Via.find(params[:id])
    @via.destroy

    respond_to do |format|
      format.html { redirect_to(vias_url) }
      format.xml  { head :ok }
    end
  end
end
