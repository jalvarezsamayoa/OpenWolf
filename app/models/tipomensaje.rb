class Tipomensaje < ActiveRecord::Base  
  has_many :mensajes
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  def to_label
    nombre
  end
end
# == Schema Information
#
# Table name: tipomensajes
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

