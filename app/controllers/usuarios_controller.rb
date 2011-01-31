class UsuariosController < ApplicationController
  before_filter :requiere_usuario
  before_filter :get_extra_data
  
  # GET /usuarios
  # GET /usuarios.xml
  def index
    
    if usuario_actual.has_role?(:superadmin)
      @usuarios = Usuario.nombre_like(params[:search]).paginate :page=>params[:page], :per_page=>25
    else
      @usuarios = usuario_actual.institucion.usuarios.nombre_like(params[:search]).paginate :page=>params[:page], :per_page=>25
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

    @usuario_es_admin = nivel_seguridad(usuario_actual,'administrador')
    @usuario_es_superadmin =  nivel_seguridad(usuario_actual,'superadmin')
    @disabled = !@usuario_es_superadmin

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

    @usuario_es_admin = nivel_seguridad(usuario_actual,'administrador')
    @usuario_es_superadmin =  nivel_seguridad(usuario_actual,'superadmin')
    
    @disabled = !@usuario_es_superadmin

    
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = Usuario.new(params[:usuario])
    
    @usuario.institucion_id = usuario_actual.institucion_id if @usuario.institucion_id.nil?

    if @usuario.save
      flash[:notice] = 'Usuario creado con exito.'
      redirect_to(@usuario) 
    else
      render :action => "new" 
    end #save

  end #create

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])

    if params[:usuario][:password].nil? or params[:usuario][:password].empty?
      params[:usuario].delete(:password)
      params[:usuario].delete(:password_confirmation)
    end
    
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
