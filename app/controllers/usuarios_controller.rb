class UsuariosController < ApplicationController
  before_filter :requiere_usuario
  before_filter :obtener_nivel_de_seguridad
  before_filter :get_extra_data

  
  # GET /usuarios
  # GET /usuarios.xml
  def index
    
    if @usuario_es_superadmin
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
    get_usuario()

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new
    @disabled = !@usuario_es_superadmin    

    #verificar a que institucion pueden asignar usuarios
    unless @usuario_es_superadmin
      @usuario.institucion_id = usuario_actual.institucion_id      
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    get_usuario()    
    @disabled = !@usuario_es_superadmin    
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create    
    @usuario = Usuario.new(params[:usuario])
    @usuario.institucion_id = usuario_actual.institucion_id unless @usuario_es_superadmin

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
    get_usuario()
    
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
    get_usuario()   
    @usuario.destroy

    respond_to do |format|
      if @usuario.destroy
      format.html { redirect_to(estados_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show"}
      end
    end 
  end

  # Muestra forma para actualizacion de datos de perfil de usuario
  def perfil
    @usuario = usuario_actual
    @perfil = true
  end
  
  private
  
  def get_extra_data
    #    @puestos = Puesto.all
  end

  def get_usuario
    if @usuario_es_superadmin
      @usuario = Usuario.find(params[:id])
    else
      @usuario = usuario_actual.institucion.usuarios.find(params[:id])
    end
  end

  def obtener_nivel_de_seguridad
    @usuario_es_admin = nivel_seguridad(usuario_actual,'administrador')
    @usuario_es_superadmin =  nivel_seguridad(usuario_actual,'superadmin')
  end
  
end
