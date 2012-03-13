require File.dirname(__FILE__) + '/../spec_helper'

describe Institucion, :solr => true do

  def setup_defaults
    @institucion = Factory(:institucion)
    @usuario = Factory(:usuario, :institucion => @institucion)
    
    @departamento = Factory(:departamento)
    @municipio = Factory(:municipio, :departamento => @departamento)
    @via = Factory(:via)
    @profesion = Factory(:profesion)
    @genero = Factory(:genero)
    @rangoedad = Factory(:rangoedad)
    @clasificacion = Factory(:clasificacion)
    @documentoclasificacion = Factory(:documentoclasificacion)

    @opciones_solicitud = {:departamento => @departamento,
      :municipio => @municipio,
      :via => @via,
      :profesion => @profesion,
      :genero => @genero,
      :rangoedad => @rangoedad,
      :clasificacion => @clasificacion,
      :documentoclasificacion => @documentoclasificacion,
      :anulada => false,
      :dont_send_email => true,
      :institucion => @institucion,
      :usuario => @usuario}
  end
  
  def solicitud_activa(opts = nil)
    unless opts.nil?
      opciones = @opciones_solicitud.merge(opts)
    else
      opciones = @opciones_solicitud
    end
    Factory(:solicitud, opciones)
  end

  def solicitud_entregada(opts = nil)
    unless opts.nil?
      opciones = @opciones_solicitud.merge(opts)
    else
      opciones = @opciones_solicitud
    end
    Factory(:solicitud, opciones)
  end
  
  before(:each) do 
    setup_defaults
  end
    
  describe '#total_solicitudes' do    
    it 'debe regresar la cantidad de solicitudes activas' do
      2.times { solicitud_activa }
      @institucion.total_solicitudes.should == 2
    end    
  end

   describe '#solicitudes_por_estado' do
     fixtures :estados
    
     it 'deber regresar el numero de solicitudes agrupadas por estado' do
       estados = Estado.all
       estados.each do |estado|
        solicitud_activa({:estado => estado, :dont_set_estado => true})
       end
       @institucion.solicitudes_por_estado.should have(estados.size).records
     end    
  end

  describe '#solicitudes_por_ano' do
    fixtures :estados
    
    it 'deber regresar el numero de solicitudes completadas agrupadas por ano' do


      
       estados.each do |estado|
        solicitud_entregada(fecha_xxx)
       end
       @institucion.solicitudes_por_estado.should have(estados.size).records
    end
    
  end
  
end
# == Schema Information
#
# Table name: instituciones
#
#  id                     :integer         not null, primary key
#  nombre                 :string(255)     not null
#  tipoinstitucion_id     :integer         not null
#  parent_id              :integer
#  lft                    :integer
#  rgt                    :integer
#  created_at             :datetime
#  updated_at             :datetime
#  codigo                 :string(255)     default("9999-9999"), not null
#  abreviatura            :string(255)     default("NA"), not null
#  direccion              :string(255)
#  telefono               :string(255)
#  logo_file_name         :string(255)
#  logo_content_type      :string(255)
#  logo_file_size         :integer
#  logo_updated_at        :datetime
#  activa                 :boolean         default(FALSE)
#  usasolicitudesprivadas :boolean         default(FALSE)
#  unidad_ejecutora       :string(255)
#  entidad                :string(255)
#  webpage                :string(255)
#  email                  :string(255)
#

