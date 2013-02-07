class Documentoclasificacion < ActiveRecord::Base
  #versioned
  
  SOLICITUDINFOPUBLICA = '9001'
  RESOLUCION = '9002'
  REVISION = '9003'
  
  has_many :documentos
  belongs_to :documentocategoria

  validates_presence_of :nombre, :codigo
  validates_uniqueness_of :codigo
  validates_uniqueness_of :nombre, :scope => :documentocategoria_id

  default_scope :include => :documentocategoria, :order => :nombre

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("documentoclasificaciones.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
end
# == Schema Information
#
# Table name: documentoclasificaciones
#
#  id                    :integer         not null, primary key
#  nombre                :string(255)
#  documentocategoria_id :integer
#  codigo                :string(255)
#  plantilla             :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

