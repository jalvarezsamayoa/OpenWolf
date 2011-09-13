class ReportesController < ApplicationController
  before_filter :requiere_usuario

  #displays pdf report with vendors balance
  def solicitudes
    report = SolicitudesReport.new(:page_size => 'LEGAL',
                                   :page_layout => :landscape)
    report.reporttitle  = 'REPORTES DE SOLICITUDES'
    report.items = Solicitud.find(:all, :conditions => ["solicitudes.institucion_id = ? and solicitudes.anulada = ?", usuario_actual.institucion_id, false], :order => :numero)
    output = report.to_pdf
    
    file_name = "solicitudes_" + Time.now.to_i.to_s + ".pdf"
    
    respond_to do |format|
      format.pdf do
        send_data output, :filename => file_name, 
        :type => "application/pdf"
      end
    end
  end

  def solicitudes_xml
    @solicitudes = Solicitud.where("solicitudes.institucion_id = ? and solicitudes.anulada = ?", usuario_actual.institucion_id, false).order(:numero)
    
    # respond_to do |format|
    #   format.xml  { render :xml => @solicitudes.to_xml(:include => Solicitud.xml_options ) }
    # end
    xml_string = @solicitudes.to_xml(:include => Solicitud.xml_options )
    file_name = "solicitudes_" + Time.now.strftime("%Y-%m-%d-%H%M%S") + ".xml"
    
    send_data xml_string, :type => "text/plain", 
    :filename=>file_name,
    :disposition => 'attachment'
  end

  def solicitudes_csv
    institucion_nombre = usuario_actual.institucion.abreviatura
    csv_string = Solicitud.export_to_csv(:institucion_id => usuario_actual.institucion_id)
    send_data csv_string, :type => "text/plain", 
    :filename=>"reporte_solicitudes_#{institucion_nombre}_#{Time.now.to_i}.csv",
    :disposition => 'attachment'
  end

  def instituciones_activas
    @instituciones = Institucion.activas.paginate(:page => params[:page])
  end

end
