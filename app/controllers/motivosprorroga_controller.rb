class MotivosprorrogaController < ApplicationController
  # GET /motivosprorroga
  # GET /motivosprorroga.xml
  def index
    @motivosprorroga = Motivoprorroga.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @motivosprorroga }
    end
  end

  # GET /motivosprorroga/1
  # GET /motivosprorroga/1.xml
  def show
    @motivoprorroga = Motivoprorroga.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @motivoprorroga }
    end
  end

  # GET /motivosprorroga/new
  # GET /motivosprorroga/new.xml
  def new
    @motivoprorroga = Motivoprorroga.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @motivoprorroga }
    end
  end

  # GET /motivosprorroga/1/edit
  def edit
    @motivoprorroga = Motivoprorroga.find(params[:id])
  end

  # POST /motivosprorroga
  # POST /motivosprorroga.xml
  def create
    @motivoprorroga = Motivoprorroga.new(params[:motivoprorroga])

    respond_to do |format|
      if @motivoprorroga.save
        format.html { redirect_to(@motivoprorroga, :notice => 'Motivoprorroga was successfully created.') }
        format.xml  { render :xml => @motivoprorroga, :status => :created, :location => @motivoprorroga }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @motivoprorroga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /motivosprorroga/1
  # PUT /motivosprorroga/1.xml
  def update
    @motivoprorroga = Motivoprorroga.find(params[:id])

    respond_to do |format|
      if @motivoprorroga.update_attributes(params[:motivoprorroga])
        format.html { redirect_to(@motivoprorroga, :notice => 'Motivoprorroga was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @motivoprorroga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /motivosprorroga/1
  # DELETE /motivosprorroga/1.xml
  def destroy
    @motivoprorroga = Motivoprorroga.find(params[:id])
    @motivoprorroga.destroy

    respond_to do |format|
      format.html { redirect_to(motivosprorroga_url) }
      format.xml  { head :ok }
    end
  end
end
