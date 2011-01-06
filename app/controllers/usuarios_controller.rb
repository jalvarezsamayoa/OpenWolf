class UsuariosController < ApplicationController
  before_filter :requiere_usuario
  before_filter :get_extra_data
  
  # GET /usuarios
  # GET /usuarios.xml
  def index
    p = '@'
    p = '%'+ params[:search][0] +'%' if params[:search]
    
    if usuario_actual.has_role?(:superadmin)
      @usuarios = Usuario.where("usuarios.username like ? or usuarios.nombre like ? or usuarios.cargo like ?",p, p,p).paginate :page=>params[:page], :per_page=>10, :include => [:institucion]
    else
      @usuarios = usuario_actual.institucion.usuarios.where("usuarios.username like ? or usuarios.nombre like ? or usuarios.cargo like ?",p,p,p).paginate :page=>params[:page], :per_page=>10, :include => [:institucion]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new

    #verificar a que institucion pueden asignar usuarios
    unless usuario_actual.has_role?(:superadmin)
      @usuario.institucion_id = usuario_actual.institucion_id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.institucion_id = usuario_actual.institucion_id if @usuario.institucion.nil?

    respond_to do |format|

      @usuario.save do |result|
        if result
          flash[:notice] = 'Usuario creado con exito.'
          format.html { redirect_to(@usuario) }
          format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
        end #if resutl
      end #save
    end #respond
  end #create

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])
        
    if @usuario.update_attributes(params[:usuario])
      flash[:notice] = 'Usuario actualizado con exito.'
      if usuario_actual.has_role?(:superadmin) or usuario_actual.has_role?(:localadmin)
        redirect_to(@usuario)
      else
        redirect_to(main_index_path)
      end
    else
      render :action => "edit" 
    end #result

  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end

  # Muestra forma para actualizacion de datos de perfil de usuario
  def perfil
    @usuario = usuario_actual  
  end
  
  private
  
  def get_extra_data
    #    @puestos = Puesto.all
  end
end
