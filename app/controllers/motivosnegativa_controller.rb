class MotivosnegativaController < ApplicationController
  # GET /motivosnegativa
  # GET /motivosnegativa.xml
  def index
    @motivosnegativa = Motivonegativa.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @motivosnegativa }
    end
  end

  # GET /motivosnegativa/1
  # GET /motivosnegativa/1.xml
  def show
    @motivonegativa = Motivonegativa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @motivonegativa }
    end
  end

  # GET /motivosnegativa/new
  # GET /motivosnegativa/new.xml
  def new
    @motivonegativa = Motivonegativa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @motivonegativa }
    end
  end

  # GET /motivosnegativa/1/edit
  def edit
    @motivonegativa = Motivonegativa.find(params[:id])
  end

  # POST /motivosnegativa
  # POST /motivosnegativa.xml
  def create
    @motivonegativa = Motivonegativa.new(params[:motivonegativa])

    respond_to do |format|
      if @motivonegativa.save
        format.html { redirect_to(@motivonegativa, :notice => 'Motivonegativa was successfully created.') }
        format.xml  { render :xml => @motivonegativa, :status => :created, :location => @motivonegativa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @motivonegativa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /motivosnegativa/1
  # PUT /motivosnegativa/1.xml
  def update
    @motivonegativa = Motivonegativa.find(params[:id])

    respond_to do |format|
      if @motivonegativa.update_attributes(params[:motivonegativa])
        format.html { redirect_to(@motivonegativa, :notice => 'Motivonegativa was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @motivonegativa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /motivosnegativa/1
  # DELETE /motivosnegativa/1.xml
  def destroy
    @motivonegativa = Motivonegativa.find(params[:id])
    @motivonegativa.destroy

    respond_to do |format|
      format.html { redirect_to(motivosnegativa_url) }
      format.xml  { head :ok }
    end
  end
end
