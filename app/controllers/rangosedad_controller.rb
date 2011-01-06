class RangosedadController < ApplicationController
  # GET /rangosedad
  # GET /rangosedad.xml
  def index
    @rangosedad = Rangoedad.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rangosedad }
    end
  end

  # GET /rangosedad/1
  # GET /rangosedad/1.xml
  def show
    @rangoedad = Rangoedad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rangoedad }
    end
  end

  # GET /rangosedad/new
  # GET /rangosedad/new.xml
  def new
    @rangoedad = Rangoedad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rangoedad }
    end
  end

  # GET /rangosedad/1/edit
  def edit
    @rangoedad = Rangoedad.find(params[:id])
  end

  # POST /rangosedad
  # POST /rangosedad.xml
  def create
    @rangoedad = Rangoedad.new(params[:rangoedad])

    respond_to do |format|
      if @rangoedad.save
        format.html { redirect_to(@rangoedad, :notice => 'Rangoedad was successfully created.') }
        format.xml  { render :xml => @rangoedad, :status => :created, :location => @rangoedad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rangoedad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rangosedad/1
  # PUT /rangosedad/1.xml
  def update
    @rangoedad = Rangoedad.find(params[:id])

    respond_to do |format|
      if @rangoedad.update_attributes(params[:rangoedad])
        format.html { redirect_to(@rangoedad, :notice => 'Rangoedad was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rangoedad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rangosedad/1
  # DELETE /rangosedad/1.xml
  def destroy
    @rangoedad = Rangoedad.find(params[:id])
    @rangoedad.destroy

    respond_to do |format|
      format.html { redirect_to(rangosedad_url) }
      format.xml  { head :ok }
    end
  end
end
