class Institucion < ActiveRecord::Base
  versioned
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

  def total_solicitudes
    self.solicitudes.activas.count
  end

  def solicitudes_por_estado
    estados = Estado.select('estados.nombre, count(solicitudes.estado_id) as total_solicitudes').joins(:solicitudes).where("solicitudes.anulada = ? and solicitudes.institucion_id = ?",false,self.id).group('estados.nombre')
    return estados
  end

  def solicitudes_por_ano
    solicitudes =  Solicitud.find_by_sql("select extract(year from fecha_creacion) as ano,  count(solicitudes.id) as total_solicitudes from solicitudes where institucion_id = #{self.id} and anulada = #{false} group by extract(year from fecha_creacion)")

    return solicitudes
  end
  
  def solicitudes_por_mes_ano
    solicitudes =  Solicitud.find_by_sql("select extract(year from fecha_creacion) as ano, extract(month from fecha_creacion) as mes,  count(solicitudes.id) as total_solicitudes from solicitudes where institucion_id = #{self.id} and anulada = #{false} group by extract(year from fecha_creacion), extract(month from fecha_creacion)")   
    return solicitudes
  end

  def tiempo_respuesta_promedio
    tiempo = Solicitud.find_by_sql("select avg(solicitudes.tiempo_respuesta) as promedio from solicitudes where solicitudes.institucion_id = #{self.id} and solicitudes.fecha_completada is not null")    
    return tiempo[0].promedio.to_f.ceil
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
