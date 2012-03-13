# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # nuevo captcha simplificado
  include SimpleCaptcha::ControllerHelpers

  rescue_from 'Acl9::AccessDenied', :with => :acceso_denegado
  
  helper_method :usuario_actual, :current_user, :nivel_seguridad, :fix_date, :usuario_autenticado?, :usuario_actual_admin?

  layout :layout_por_recurso

  def layout_por_recurso
    if devise_controller?
      "login"
    else
      "application"
    end
  end
  
   
  def usuario_actual
    return @usuario_actual if defined?(@usuario_actual)
    @usuario_actual = current_user
  end

  def current_user
    current_usuario
  end

  def usuario_actual_admin?
    return false if usuario_actual.nil?
    return usuario_actual.has_role?(:superadmin)
  end

  def usuario_autenticado?
    return (usuario_actual ? true : false)
  end
  
  def requiere_usuario
    unless usuario_actual
      store_location
      flash[:notice] = "Debe autenticarse para ver esta pagina."
      redirect_to login_path
      return false
    end
  end
  
  def no_requiere_usuario
    if usuario_actual
      store_location
      flash[:notice] = "Debe cerrar sesión para ver esta pagina."
      redirect_to root_path
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def acceso_denegado
    if usuario_actual
      render :template => 'shared/acceso_denegado'
    else
      flash[:notice] = 'Acceso Denegado. Debe identificarse antes de ingresar.'
      redirect_to login_path
    end
  end   

  def parse_date(fecha)
    return nil if fecha.nil? or fecha.empty?
    a_fecha = fecha.split('/')
    return Date.civil(a_fecha[2].to_i, a_fecha[1].to_i, a_fecha[0].to_i)
  end

   # helpers para seguridad
  def nivel_seguridad(u = nil, nivel = 'public')
    return false if u.nil?
    
    logger.debug { "Verificando nivel: #{nivel}" }
    l_ok = false
    case nivel
    when 'superadmin'
#      logger.debug { "Es: superadmin" }
      l_ok =  u.has_role?(:superadmin)
      logger.debug { "#{l_ok}" }
    when 'administrador'
 #     logger.debug { "Es: administrador" }
      l_ok =  (u.has_role?(:superadmin) or u.has_role?(:localadmin))
      logger.debug { "#{l_ok}" }
    when 'encargadoudip'
       logger.debug { "Es: encargadoudip" }
      l_ok = (u.has_role?(:superudip))
    when 'personaludip'
      l_ok = (u.has_role?(:superudip) or u.has_role?(:userudip))
    end
    return l_ok
  end


   # transforma un string fecha con formato DD/MM/YYY a un objeto
  # fecha con formato YYYY-MM-DD que pueda ser grabado a la base de datos
  def fix_date(c_date)
    logger.debug { "c_date>#{c_date}" }
    return nil if c_date.nil?

    a_date = c_date.split('/')   
    return nil unless a_date.size == 3

    if a_date[2].size == 2
      a_date[2] = '20'+a_date[2]
    end

    new_date = Date.civil(a_date[2].to_i, a_date[1].to_i, a_date[0].to_i)

    logger.debug { "#{new_date}" }

   
    return new_date
  end

 
end
