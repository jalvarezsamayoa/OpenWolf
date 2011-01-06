class ImportarController < ApplicationController
  before_filter :requiere_usuario
    access_control do
    allow :superadmin
  end
  
  
  def index
    @instituciones = Institucion.order('nombre')
  end

  def create
    
    h = Herramienta.new
    h.importar_solicitudes(:file => params[:archivo],
                           :institucion_id => params[:institucion_id],
                           :usuario_id => usuario_actual.id,
                           :campos => params[:campos])

    @institucion = h.institucion
    @solicitudes = @institucion.solicitudes
  end

end
