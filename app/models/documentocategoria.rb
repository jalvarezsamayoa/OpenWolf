class Documentocategoria < ActiveRecord::Base
  versioned
  acts_as_nested_set

  def to_label
    nombre
  end
end
