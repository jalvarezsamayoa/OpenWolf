class Fuente < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre
end
