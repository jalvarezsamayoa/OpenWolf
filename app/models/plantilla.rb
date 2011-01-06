class Plantilla
  include Serenity::Generator

  def memo(documento)
    generate_memo(documento)
  end
 
  def generate_memo(documento)
    @numero = documento.numero
    @institucion = documento.institucion_nombre
    @autor = documento.autor_datos
    @fecha = I18n.l(documento.fecha_documento)
    @asunto = documento.asunto
    @texto = documento.texto
    render_odt RAILS_ROOT + '/public/templates/memo.odt'
  end
  
end
