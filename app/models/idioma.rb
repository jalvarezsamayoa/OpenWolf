class Idioma < ActiveRecord::Base
  has_many :solicitudes

  validates :nombre, :presence => true, :uniqueness => true

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(idiomas.nombre) like ?", valor )
   end
  }
  
  def to_label
    nombre
  end
  
end
# == Schema Information
#
# Table name: idiomas
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

