class DocumentocategoriasController < ApplicationController
  before_filter :requiere_usuario
  access_control do
    allow :superadmin
  end
  
  # GET /documentocategorias
  # GET /documentocategorias.xml
  def index
    @documentocategorias = Documentocategoria.nombre_like(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documentocategorias }
    end
  end

  # GET /documentocategorias/1
  # GET /documentocategorias/1.xml
  def show
    @documentocategoria = Documentocategoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documentocategoria }
    end
  end

  # GET /documentocategorias/new
  # GET /documentocategorias/new.xml
  def new
    @documentocategoria = Documentocategoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @documentocategoria }
    end
  end

  # GET /documentocategorias/1/edit
  def edit
    @documentocategoria = Documentocategoria.find(params[:id])
  end

  # POST /documentocategorias
  # POST /documentocategorias.xml
  def create
    @documentocategoria = Documentocategoria.new(params[:documentocategoria])

    respond_to do |format|
      if @documentocategoria.save
        format.html { redirect_to(@documentocategoria, :notice => 'Documentocategoria was successfully created.') }
        format.xml  { render :xml => @documentocategoria, :status => :created, :location => @documentocategoria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @documentocategoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documentocategorias/1
  # PUT /documentocategorias/1.xml
  def update
    @documentocategoria = Documentocategoria.find(params[:id])

    respond_to do |format|
      if @documentocategoria.update_attributes(params[:documentocategoria])
        format.html { redirect_to(@documentocategoria, :notice => 'Documentocategoria was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @documentocategoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documentocategorias/1
  # DELETE /documentocategorias/1.xml
  def destroy
    @documentocategoria = Documentocategoria.find(params[:id])
    @documentocategoria.destroy

    respond_to do |format|
      format.html { redirect_to(documentocategorias_url) }
      format.xml  { head :ok }
    end
  end
end
