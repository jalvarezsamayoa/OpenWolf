class Via < ActiveRecord::Base
  versioned
  
  validates :nombre, :presence => true, :uniqueness => true

  def to_label
    nombre
  end
  
end
