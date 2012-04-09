class Institucion < ActiveRecord::Base
  #versioned
  acts_as_nested_set

  ESTADO_GUATEMALA = 1
  TIPO_RAIZ = 1
  TIPO_PODER = 2
  TIPO_MINISTERIO = 3
  TIPO_INSTITUCION = 4
  TIPOS = {1 => "EstadoGT", 2 => "Poder", 3 => "Ministerio", 4 => "Institucion"}
  TIPOS_OPTIONS = [["EstadoGT", 1],
                   ["Poder", 2],
                   ["Ministerio", 3],
                   ["Institucion", 4]]
  

  has_attached_file :logo, :styles => { :medium => "150x150>" }, :default_url   => "missing.png"

#  has_many :puestos, :dependent => :destroy
  has_many :actividades
  has_many :usuarios
  has_many :solicitudes, :dependent => :destroy
  has_many :documentos, :dependent => :destroy
  has_many :archivos, :dependent => :destroy
  has_many :seguimientos, :dependent => :destroy
  has_many :tmp_assets, :dependent => :destroy
  
  validates_presence_of :nombre, :message=>"Campo Nombre no puede estar vacio."
  validates_uniqueness_of :nombre, :scope => :parent_id, :message=>"Nombre ya esta en uso."

    
  #TODO: aberviatura debe de ser unica
  validates :abreviatura, :presence => true

  #TODO: codigo debe de ser unica  
  validates :codigo, :presence => true
  
  validates :unidad_ejecutora, :presence => true
  validates :entidad, :presence => true
  
  #TODO: el email debe de ser unico
  validates :email, :presence => true

  before_validation(:on => :create) do
    cleanup
  end

  #####################
  # Filtros de busqueda
  #####################

  default_scope :order => "instituciones.nombre asc"
  
  scope :padres, :conditions=>["tipoinstitucion_id < ?", TIPO_INSTITUCION ], :order => :nombre
  scope :ministerios, :conditions=>["tipoinstitucion_id = ?",TIPO_MINISTERIO], :order => :nombre
  scope :instituciones, :conditions=>["tipoinstitucion_id = ?",TIPO_INSTITUCION], :order => :nombre
  scope :asignables, :conditions=>["tipoinstitucion_id = ? or tipoinstitucion_id = ?",TIPO_MINISTERIO,TIPO_INSTITUCION], :order => :nombre
  scope :activas, :conditions => ["activa = ?",true]
  scope :estado_y_activas, :conditions => ["instituciones.id = 1 or activa = ?",true]

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(instituciones.nombre) like ? or UPPER(instituciones.codigo) like ?", valor, valor )
   end
  }

  def tipo_nombre
    return TIPOS[tipoinstitucion_id]
  end

  def to_label
    nombre
  end

  def familia
    self.self_and_ancestors.asignables.concat( self.children.asignables  )
  end

  def familia_activa
    self.self_and_ancestors.activas.asignables.concat( self.children.asignables  )
  end

  ######################################
  # Metodos para estadisticas
  #####################################

  def ano_minimo
    fecha_minima = self.solicitudes.minimum("fecha_creacion")
    i_ano_min = (fecha_minima.nil? ? Date.today.year  : fecha_minima.year)   
    return i_ano_min
  end
  
  def total_solicitudes(ano = Date.today.year)
    self.solicitudes.activas.creadas_en_ano(ano).count
  end

  def solicitudes_por_estado(ano = Date.today.year)
    estados = Estado.select('estados.nombre, count(solicitudes.estado_id) as total_solicitudes').joins(:solicitudes).where("solicitudes.anulada = ? and solicitudes.institucion_id = ? and extract(year from fecha_creacion) = ?",false,self.id,ano).group('estados.nombre')
    return estados
  end

  def solicitudes_por_via_solicitud(ano = Date.today.year)
    estados = Via.select('vias.nombre, count(solicitudes.via_id) as total_solicitudes').joins(:solicitudes).where("solicitudes.anulada = ? and solicitudes.institucion_id = ? and extract(year from fecha_creacion) = ?",false,self.id,ano).group('vias.nombre')
    return estados
  end

  

  def solicitudes_por_ano
    solicitudes =  Solicitud.find_by_sql("select extract(year from fecha_creacion) as ano,  count(solicitudes.id) as total_solicitudes, avg(solicitudes.tiempo_respuesta) as promedio_dias_respuesta  from solicitudes where institucion_id = #{self.id} and anulada = #{false} and solicitudes.fecha_completada is not null group by extract(year from fecha_creacion) order by extract(year from fecha_creacion) asc")

    return solicitudes
  end
  
  def solicitudes_por_mes_ano
    solicitudes =  Solicitud.find_by_sql("select extract(year from fecha_creacion) as ano, extract(month from fecha_creacion) as mes,  count(solicitudes.id) as total_solicitudes, avg(solicitudes.tiempo_respuesta) as promedio_dias_respuesta from solicitudes where institucion_id = #{self.id} and anulada = #{false} and solicitudes.fecha_completada is not null group by extract(year from fecha_creacion), extract(month from fecha_creacion) order by extract(year from fecha_creacion) asc, extract(month from fecha_creacion) asc")   
    return solicitudes
  end

  def tiempo_respuesta_promedio(ano = Date.today.year)
    tiempo = Solicitud.find_by_sql("select avg(solicitudes.tiempo_respuesta) as promedio from solicitudes where solicitudes.institucion_id = #{self.id} and anulada = #{false} and solicitudes.fecha_completada is not null and extract(year from fecha_creacion) = #{ano}")    
    return tiempo[0].promedio.to_f.round()
  end

  def solicitudes_por_genero_ano
    solicitudes = Solicitud.find_by_sql("select genero_id, extract(year from fecha_creacion) as ano,  count(solicitudes.id) as total_solicitudes from solicitudes where institucion_id = #{self.id} and anulada = #{false}  group by genero_id, extract(year from fecha_creacion)  order by genero_id, extract(year from fecha_creacion) desc")
  end
 

  def encargado_udip
    return nil if self.usuarios.nil?
    return self.usuarios.activos.supervisores.first
  end

  
  private

  def cleanup
    
    if self.abreviatura.empty?
      unless self.nombre.empty?
        nombres = self.nombre.split(' ')      
        nombres.each {|n| self.abreviatura += n.slice(0..0) }
      end
    end

    # verficamos los codigos de la institucion
    if self.unidad_ejecutora == '0' or self.unidad_ejecutora.empty?
      self.unidad_ejecutora = '000'
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

