class Sentidoresolucion < ActiveRecord::Base
  #versioned
  
  has_many :recursosrevision

  def to_label
    nombre
  end
end
# == Schema Information
#
# Table name: sentidosresolucion
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

