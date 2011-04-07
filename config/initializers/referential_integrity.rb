class ActiveRecord::Base
  
  private

  #previene el borrar el registro si las relaciones tienen hijos
  # check_for_children({:informessupervision => "Informes Supervision"})
  def check_for_children(relationships = {})
    l_ok_to_delete = true
    relationships.each do |key, value|
      n = self.send(key).count
      if n > 0
        errors.add_to_base("No es posible borrar este registro ya que tiene #{n} #{value} asociados.")
        l_ok_to_delete = false
      end
    end    
    return l_ok_to_delete
  end
  
end
