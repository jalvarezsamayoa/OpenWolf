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

  def solicitudes_csv
    @solicitudes = Solicitud.find(:all, :conditions => ["solicitudes.institucion_id = ? and solicitudes.anulada = ?", usuario_actual.institucion_id, false], :order => :numero)
    
    csv_string = FasterCSV.generate do |csv| 
      csv <<  [Solicitud.human_attribute_name(:rpt_correlativo),
               Solicitud.human_attribute_name(:rpt_solicitud),
               Solicitud.human_attribute_name(:rpt_fechasolicitud),
               Solicitud.human_attribute_name(:rpt_tipodesolicitud),
               Solicitud.human_attribute_name(:rpt_tipoderesolucion),
               Solicitud.human_attribute_name(:rpt_fecharesolucion),
               Solicitud.human_attribute_name(:rpt_razonnopositiva),               
               Solicitud.human_attribute_name(:rpt_tiempoderespuesta),
               Solicitud.human_attribute_name(:rpt_sehasolicitadoampliacion),
               Solicitud.human_attribute_name(:rpt_fechanotificacionampliacion),
               Solicitud.human_attribute_name(:rpt_razonampliacion),
               Solicitud.human_attribute_name(:rpt_tiemposolicitadoampliacion),
               Solicitud.human_attribute_name(:rpt_recursorevision),
               Solicitud.human_attribute_name(:rpt_fechapresentacionrecursorevision),
               Solicitud.human_attribute_name(:rpt_fechanotificacionrecursorevision),
               Solicitud.human_attribute_name(:rpt_sentidoresolucion)]

      @solicitudes.each do |s|
        csv << [s.codigo,
                 s.textosolicitud,
                 l(s.fecha_creacion).to_s,
                 (s.via.nil? ? '' : s.via.nombre),
                 s.tipo_resolucion,
                 l(s.fecha_resolucion).to_s,
                 s.razon_nopositiva,
                 s.tiempo_respuesta.to_s,
                 s.hay_prorroga,
                 l(s.fecha_notificacion_prorroga).to_s,
                 s.razon_prorroga,
                 s.tiempo_ampliacion.to_s,
                 s.hay_revision,
                 l(s.fecha_revision).to_s,
                 l(s.fecha_notificacion_revision).to_s,
                 s.razon_resolucion]
      end
    end
    send_data csv_string, :type => "text/plain", 
    :filename=>"reporte_solicitudes.csv",
    :disposition => 'attachment'
  end

end
