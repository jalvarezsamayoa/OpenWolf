class Via < ActiveRecord::Base
  #versioned

  validates :nombre, :presence => true, :uniqueness => true
  
  has_many :solicitudes

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("vias.nombre like ?", "%#{nombre}%" )
    end
  }

  def to_label
    nombre
  end

end
# == Schema Information
#
# Table name: vias
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

