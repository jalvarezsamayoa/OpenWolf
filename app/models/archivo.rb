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
# == Schema Information
#
# Table name: archivos
#
#  id             :integer         not null, primary key
#  nombre         :string(255)     not null
#  institucion_id :integer         not null
#  created_at     :datetime
#  updated_at     :datetime
#

