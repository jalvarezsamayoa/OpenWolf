class DocumentosController < ApplicationController
  uses_tiny_mce
  
  def index
#    @documentos =
    #    usuario_actual.documentos.numero_or_asunto_like(params[:search]).paginate(:page => params[:page])
        @documentos = usuario_actual.documentos.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documentos }
    end
  end
  
  def show
    @documento = Documento.find(params[:id])

    @hay_archivos = (@documento.institucion.archivos.count > 0)
      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documento }
    end
  end
  
  def new
    @documento = Documento.new
    @documento.fecha_documento = l(Date.today)
    @documento.fecha_recepcion = l(Date.today)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @documento }
    end
  end
  
  def edit
    @documento = Documento.find(params[:id])
  end
  
  def create
    @documento = Documento.new(params[:documento])
    
    @documento.usuario_id = usuario_actual.id
    @documento.autor_id = usuario_actual.id
    @documento.fecha_documento = parse_date(params[:documento]["fecha_documento"])
    @documento.fecha_recepcion = parse_date(params[:documento]["fecha_recepcion"])

    
    respond_to do |format|
      if @documento.save
        flash[:notice] = 'Documento was successfully created.'
        format.html { redirect_to(@documento) }
        format.xml  { render :xml => @documento, :status => :created, :location => @documento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @documento.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @documento = Documento.find(params[:id])
    
    respond_to do |format|
      if @documento.update_attributes(params[:documento])
        flash[:notice] = 'Documento ha sido actualizado con exito.'
        format.html { redirect_to(@documento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @documento.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @documento = Documento.find(params[:id])
    @documento.destroy
    
    respond_to do |format|
      format.html { redirect_to(documentos_url) }
      format.xml  { head :ok }
    end
  end

  def plantilla
    @documento = Documento.find(params[:id])
    p = Plantilla.new
    p.memo(@documento)    
     send_file RAILS_ROOT+'/public/templates/memo_output.odt', :type => "application/odt",
     :filename => "memo.odt",
     :disposition => 'attachment'
  end

  def archivar
    @documento = Documento.find(params[:id])

    @archivos = @documento.institucion.archivos
    
    respond_to do |format|
      format.js
    end
  end

  def trasladar
    @documento = Documento.find(params[:id])
    @documentotraslado = Documentotraslado.new
    @documentotraslado.documento_id = @documento.id
    @documentotraslado.institucion_id = current_user.institucion.id
    

    @enlaces = @documento.institucion.usuarios.enlaces
    
    respond_to do |format|
      format.js
    end
  end

  
end
