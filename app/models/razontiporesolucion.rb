class Razontiporesolucion < ActiveRecord::Base
  #versioned
  validates_presence_of :nombre
  validates_uniqueness_of :nombre, :scope => :tiporesolucion_id

  belongs_to :tiporesolucion

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("razonresoluciones.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
end
# == Schema Information
#
# Table name: razonestiposresoluciones
#
#  id                  :integer         not null, primary key
#  nombre              :string(255)     not null
#  tiporesolucion_id   :integer         not null
#  created_at          :datetime
#  updated_at          :datetime
#  informacion_publica :boolean         default(TRUE), not null
#

