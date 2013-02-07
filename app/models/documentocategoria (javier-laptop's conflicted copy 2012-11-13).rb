class Documentocategoria < ActiveRecord::Base
  #versioned
  acts_as_nested_set

  validates_presence_of :nombre
  validates_uniqueness_of :nombre, :scope => :parent_id

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("documentocategorias.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
end
# == Schema Information
#
# Table name: documentocategorias
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  created_at :datetime
#  updated_at :datetime
#

