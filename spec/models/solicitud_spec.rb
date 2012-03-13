require File.dirname(__FILE__) + '/../spec_helper'

describe Solicitud do
  
  before(:each) do
    @solicitud = Factory(:solicitud)
  end
  
  it "debe ser valido" do
    @solicitud.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end


  describe '#es_pertinente?' do   
    it 'true si usuario esta relacionado a solicitud' do
      pending
    end

    it "true si usuario pertenece a unidad de informacion" do
      pending
    end

    it "false si usuario no esta relacionado a solicitud" do
      pending
    end

    it "false si usuario no pertenece a unidad de informacion" do
      pending
    end    
  end

  
end
# == Schema Information
#
# Table name: solicitudes
#
#  id                          :integer         not null, primary key
#  usuario_id                  :integer         not null
#  codigo                      :string(255)     default("XXXXX-999999-9999"), not null
#  institucion_id              :integer         not null
#  tiposolicitud_id            :integer         default(1)
#  via_id                      :integer         default(1), not null
#  fecha_creacion              :date
#  fecha_programada            :date
#  fecha_entregada             :date
#  fecha_resolucion            :date
#  fecha_prorroga              :date
#  fecha_completada            :date
#  solicitante_nombre          :string(255)     not null
#  solicitante_identificacion  :string(255)
#  solicitante_direccion       :string(255)
#  solicitante_telefonos       :string(255)
#  solicitante_institucion     :string(255)
#  departamento_id             :integer
#  municipio_id                :integer
#  email                       :string(255)
#  forma_entrega               :string(255)
#  observaciones               :text
#  ubicacion_url               :string(255)
#  estado_id                   :integer         default(1)
#  created_at                  :datetime
#  updated_at                  :datetime
#  textosolicitud              :text
#  asignada                    :boolean
#  ano                         :integer         not null
#  numero                      :integer         not null
#  profesion_id                :integer
#  genero_id                   :integer
#  rangoedad_id                :integer
#  clasificacion_id            :integer
#  dias_respuesta              :integer
#  dias_prorroga               :integer
#  motivonegativa_id           :integer
#  motivoprorroga_id           :integer
#  informacion_publica         :boolean         default(TRUE), not null
#  origen_id                   :integer         default(1)
#  documentoclasificacion_id   :integer         default(1)
#  idioma_id                   :integer         default(12), not null
#  anulada                     :boolean         default(FALSE)
#  tiempo_respuesta            :integer         default(0)
#  tiempo_respuesta_calendario :integer         default(0)
#  reserva_temporal            :boolean         default(FALSE)
#

