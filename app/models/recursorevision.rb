class Recursorevision < ActiveRecord::Base
  #versioned
  
  belongs_to :solicitud
  belongs_to :usuario
  belongs_to :institucion
  belongs_to :sentidoresolucion

  validates_presence_of :fecha_presentacion, :descripcion, :numero
  validates_uniqueness_of :numero

  before_validation(:on => :create) do
    cleanup
  end

  def nuevo_numero
    i = Recursorevision.count(:conditions => ["institucion_id = ? and date_part(\'year\',created_at) = ?", self.institucion_id, Date.today.year ] ).to_i + 1
    
    self.numero = self.institucion.codigo + '-' + Documentoclasificacion::REVISION +  '-' +  Date.today.year.to_s + '-' + i.to_s.rjust(6,'0')
  end
  
  def cleanup
    self.institucion_id = self.usuario.institucion_id
    self.numero = self.nuevo_numero if (self.numero.nil? or self.numero.empty?)
  end
end
# == Schema Information
#
# Table name: recursosrevision
#
#  id                        :integer         not null, primary key
#  solicitud_id              :integer
#  fecha_presentacion        :date
#  fecha_notificacion        :date
#  fecha_resolucion          :date
#  descripcion               :text
#  sentidoresolucion_id      :integer
#  institucion_id            :integer
#  usuario_id                :integer
#  created_at                :datetime
#  updated_at                :datetime
#  numero                    :string(255)
#  documentoclasificacion_id :integer         default(3)
#

