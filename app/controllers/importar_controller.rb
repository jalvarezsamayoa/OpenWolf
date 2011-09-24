class ImportarController < ApplicationController
  before_filter :requiere_usuario
  access_control do
    allow :superadmin
  end


  def index
    @instituciones = Institucion.order('nombre')
  end

  def create

    TempAsset.delete_all
      
    @tmpasset = TempAsset.new(:institucion_id => params[:institucion_id],
                              :usuario_id => usuario_actual.id,
                               :archivo => params[:archivo],
                               :options => Marshal.dump(params[:campos]) )
      
    @tmpasset.save!    
    @tmpasset.importar_archivo
        
    flash[:notice] = "Importando archivo..."

    redirect_to status_importar_path(1)
  end

 
  def status
#    @tmpasset = TempAsset.find(params[:id])
    @log = WorkerLog.limit(15)
  end
end
