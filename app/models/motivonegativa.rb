class Motivonegativa < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre
  
  has_many :solicitudes

  def to_label
    nombre
  end
end
