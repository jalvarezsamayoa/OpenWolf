class Motivoprorroga < ActiveRecord::Base
  #versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre
  
  has_many :solicitudes

  def to_label
    nombre
  end
end
# == Schema Information
#
# Table name: motivosprorroga
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

