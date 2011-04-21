class EstadisticasController < ApplicationController
  layout 'portal'
  
  def index
    @instituciones = Institucion.activas.order(:nombre) 
  end

  def show
    @institucion = Institucion.activas.find(params[:id])
  end
  
end
