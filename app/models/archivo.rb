class Archivo < ActiveRecord::Base
  validates :nombre, :presence => true, :uniqueness => true
  validates :institucion_id, :presence => true

  belongs_to :institucion
  has_many :documentos

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(archivos.nombre) like ?", valor )
   end
  }


  def to_label
    nombre
  end
  
end
