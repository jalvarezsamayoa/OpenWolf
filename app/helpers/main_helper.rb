module MainHelper

  def class_estado_asignacion(solicitud)
    c_result = "class='"
    if solicitud.atrasada?
      c_result += "error"
    elsif solicitud.terminada?
      c_result += "success"
    end
    c_result += "'"
    return c_result
  end
  
end
