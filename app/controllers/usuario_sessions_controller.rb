class UsuarioSessionsController < ApplicationController
  
  def new
    @usuario_session = UsuarioSession.new
    render :layout => 'login'
  end
  
  def create
    @usuario_session = UsuarioSession.new(params[:usuario_session])
    @usuario_session.save do |result|
      if result
        logger.debug { "Ok" }
        flash[:notice] = "Usuario autenticado con exito."
        redirect_to root_url
      else
        logger.debug { "Fallo" }
        flash[:error] = "Autenticacion fallida. Por favor verifique sus credenciales."
        render :action => 'new', :layout => 'login'
      end
    end
  end

  
  def destroy
    usuario_actual_session.destroy unless usuario_actual.nil?
    flash[:notice] = "Sesion Cerrada."
    redirect_back_or_default portal_index_url
  end
end
