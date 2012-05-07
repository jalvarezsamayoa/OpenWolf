class EstadisticasController < ApplicationController
  layout 'portal'
   before_filter :inicializar_busqueda

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

  def inicializar_busqueda
     @busqueda = Busqueda.new
  end
end
