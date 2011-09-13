# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  #   inflect.plural /^(ox)$/i, '\1en'
  #   inflect.singular /^(ox)en/i, '\1'
  #   inflect.irregular 'person', 'people'
  #   inflect.uncountable %w( fish sheep )
  inflect.irregular 'via', 'vias'
  inflect.irregular 'institucion', 'instituciones'
  inflect.irregular 'solicitud', 'solicitudes'
  inflect.irregular 'actividad', 'actividades'
  inflect.irregular 'profesion', 'profesiones'
  inflect.irregular 'rangoedad', 'rangosedad'
  inflect.irregular 'clasificacion', 'clasificaciones'
  inflect.irregular 'motivonegativa', 'motivosnegativa'
  inflect.irregular 'motivoprorroga', 'motivosprorroga'
  inflect.irregular 'resolucion', 'resoluciones'
  inflect.irregular 'tiporesolucion', 'tiposresoluciones'
  inflect.irregular 'razontiporesolucion', 'razonestiposresoluciones'
  inflect.irregular 'notificacion', 'notificaciones'
  inflect.irregular 'recursorevision', 'recursosrevision'
  inflect.irregular 'sentidoresolucion', 'sentidosresolucion'
  inflect.irregular 'mensaje', 'mensajes'
  inflect.irregular 'documentocategoria', 'documentocategorias'
  inflect.irregular 'nota', 'notas'
  inflect.irregular 'idioma', 'idiomas'
  inflect.uncountable %w( portal solicitud_informacion importar)
end
