class Profesion < ActiveRecord::Base
  #versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  has_many :solicitudes

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(profesiones.nombre) like ?", valor )
   end
  }

  def to_label
    nombre
  end
  
end
# == Schema Information
#
# Table name: profesiones
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

