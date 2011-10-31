class EstadisticasController < ApplicationController
  layout 'portal'
  
  def index
    @instituciones = Institucion.activas.order(:nombre) 
  end

  def show
    @institucion = Institucion.activas.find(params[:id])
    n = @institucion.solicitudes.activas.count
    if n == 0
      flash[:notice] = "No existes solicitudes activas para esta institucion."
      redirect_to :action => 'index'
    end
  end
  
end
