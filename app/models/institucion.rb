class Institucion < ActiveRecord::Base
  versioned
  acts_as_nested_set
  
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
  
  validates_presence_of :nombre, :message=>"Campo Nombre no puede estar vacio."
  validates_uniqueness_of :nombre, :scope => :parent_id, :message=>"Nombre ya esta en uso."

  before_validation(:on => :create) do
    cleanup
  end

  #####################
  # Filtros de busqueda
  #####################

  default_scope :order => "nombre asc"
  
  scope :padres, :conditions=>["tipoinstitucion_id < ?", TIPO_INSTITUCION ], :order => :nombre
  scope :ministerios, :conditions=>["tipoinstitucion_id = ?",TIPO_MINISTERIO], :order => :nombre
  scope :instituciones, :conditions=>["tipoinstitucion_id = ?",TIPO_INSTITUCION], :order => :nombre
  scope :asignables, :conditions=>["tipoinstitucion_id = ? or tipoinstitucion_id = ?",TIPO_MINISTERIO,TIPO_INSTITUCION], :order => :nombre
  scope :activas, :conditions => ["activa = ?",true]

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

  def cleanup
    if self.abreviatura.empty?
      unless self.nombre.empty?
        nombres = self.nombre.split(' ')      
        nombres.each {|n| self.abreviatura += n.slice(0..0) }
      end
    end
  end
  
end
