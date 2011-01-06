class SolicitudInformacionController < ApplicationController
  layout 'portal'
#   before_filter :get_institucion
  before_filter :get_data

  
  def index
    render :new
  end

  def new   
    @solicitud = Solicitud.new
    @solicitud.solicitante_nombre = ""    

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @solicitud = Solicitud.new(params[:solicitud])
    @solicitud.origen_id = Solicitud::ORIGEN_PORTAL
           
    respond_to do |format|
      if @solicitud.save
        flash[:notice] = 'Solicitud creada con exito.'
        format.html { redirect_to solicitud_portal_path(@solicitud) }
      else
        logger.debug { "Error #{@solicitud.errors.inspect}" }
        format.html { render :action => "new" }
      end
    end
  end
  
  def show

    @solicitud = Solicitud.find(params[:id])
    @actividades = @solicitud.actividades
    @documentos = @solicitud.documentos
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solicitud }
    end
  end
  

  private

  def get_institucion    
    @institucion = usuario_actual.institucion
  end

  def get_data
 #   @vias = Via.all
#    @municipios = Departamento.first.municipios.all(:order => "municipios.nombre")
  end
end
