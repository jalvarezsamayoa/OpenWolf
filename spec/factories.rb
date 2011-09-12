Factory.sequence :count do |n|
  n
end

def na
  'No Disponible'
end

Factory.define :institucion do |i|
  i.sequence(:nombre) {|i| "institucion_#{Factory.next(:count)}"}
  i.tipoinstitucion_id Institucion::TIPO_MINISTERIO
  i.parent_id nil
  i.sequence(:codigo) {|i| "codigo_#{Factory.next(:count)}"}
  i.sequence(:abreviatura) {|i| "ABR_#{Factory.next(:count)}"}
  i.direccion { Faker::Address.street_address }
  i.telefono { Faker::PhoneNumber.phone_number }
  i.activa true
  i.usasolicitudesprivadas false
  i.unidad_ejecutora {|i| "UE_#{Factory.next(:count)}"}
  i.entidad {|i| "ENT_#{Factory.next(:count)}"}
  i.webpage { Faker::Internet.domain_name }
  i.email { Faker::Internet.email }
end

Factory.define :genero do |genero|
  genero.sequence(:nombre) {|genero| "genero_#{Factory.next(:count)}"}
end

Factory.define :usuario do |u|
  u.sequence(:username) {|u| "usuario_#{Factory.next(:count)}"}
  u.email { Faker::Internet.email }
  u.nombre { Faker::Name.name }
  u.cargo 'Puesto usuario'
  u.association :institucion
  u.essupervisorarea false
  u.password '123456'
  u.genero false
  u.fecha_nacimiento Date.today - 18.years
  u.direccion { Faker::Address.street_address }
  u.telefonos { Faker::PhoneNumber.phone_number }
  u.puesto_id nil  
end

Factory.define :clasificacion do |clasificacion|
  clasificacion.sequence(:nombre) {|clasificacion| "clasificacion_#{Factory.next(:count)}"}
end

Factory.define :documentocategoria do |dc|
  dc.sequence(:nombre) {|dc| "documentocategoria_#{Factory.next(:count)}"}
  dc.parent_id nil
end

Factory.define :documentoclasificacion do |dc|
  dc.sequence(:nombre) {|dc| "documentoclasificacion_#{Factory.next(:count)}"}
  dc.association :documentocategoria
  dc.sequence(:codigo) { |c| "codigo_#{Factory.next(:count)}" }
  dc.plantilla nil
end

Factory.define :documentodestinatario do |dd|
  dd.association :documento
  dd.copia_id nil
  dd.association :usuario
  dd.original true
  dd.documentoestado_id Documentodestinatario::ESTADO_NOENTREGADO
  dd.association :institucion
  dd.puesto 'Nombre Puesto'
  dd.departamento 'Nombre Departamento'
end

Factory.define :documento do |d|
  d.sequence(:numero) {|d| "numero_#{Factory.next(:count)}"}
  d.origen_id Documento::ORIGEN_INTERNO
  d.association :documentoclasificacion
  d.association :documentocategoria
  d.fecha_documento Date.today
  d.association :autor, :factory => :usuario
  d.asunto { Faker::Lorem.sentence }
  d.texto { Faker::Lorem.paragraphs }
  d.fecha_recepcion Date.today
  d.remitente_nombre { Faker::Name.name }
  d.remitente_direccion { Faker::Address.street_address }
  d.remitente_telefonos { Faker::PhoneNumber.phone_number }
  d.remitente_email { Faker::Internet.email }
  d.estado_envio_id Documento::ESTADO_BORRADOR
  d.original true
  d.association :usuario
  d.association :institucion
  d.parent_id nil  
end

Factory.define :estado do |estado|
  estado.sequence(:nombre) {|estado| "estado_#{Factory.next(:count)}"}
  estado.final false
  estado.puede_entregar false
  estado.modulo_id Estado::MODULO_LAIP
end



Factory.define :motivonegativa do |mn|
  mn.sequence(:nombre) {|mn| "motivonegativa_#{Factory.next(:count)}"}
end

Factory.define :motivoprorroga do |mp|
  mp.sequence(:nombre) {|mp| "motivoprorroga_#{Factory.next(:count)}"}
end

Factory.define :departamento do |departamento|
  departamento.sequence(:nombre) {|departamento| "Departamento_#{Factory.next(:count)}"}
  departamento.sequence(:abreviatura) {|departamento| "ABR_#{Factory.next(:count)}" } 
end

Factory.define :municipio do |municipio|
  municipio.sequence(:nombre) {|municipio| "Municipio_#{Factory.next(:count)}"}
  municipio.association :departamento
end

Factory.define :profesion do |p|
  p.sequence(:nombre) {|p| "profesion_#{Factory.next(:count)}"}
end

Factory.define :puesto do |p|
  p.sequence(:nombre) {|p| "puesto_#{Factory.next(:count)}"}
  p.association :institucion
end

Factory.define :rangoedad do |re|
  re.sequence(:nombre) {|re| "rangoedad_#{Factory.next(:count)}"}
end

Factory.define :razontiporesolucion do |rtr|
  rtr.sequence(:nombre) {|rtr| "razontiporesolucion_#{Factory.next(:count)}"}
  rtr.association :tiporesolucion
  rtr.informacion_publica true
end

Factory.define :recursorevision do |rr|
  rr.association :solicitud
  rr.fecha_presentacion Date.today
  rr.fecha_notifiacion Date.today
  rr.fecha_resolucion Date.today
  rr.descripcion { Faker::Lorem.sentence }
  rr.association :sentidoresolucion
  rr.association :institucion
  rr.association :usuario
  rr.sequence(:numero) {|rtr| "numero_#{Factory.next(:count)}"}
  rr.association :documentoclasificacion
end

Factory.define :resolucion do |r|
  r.sequence(:numero) {|r| "numero_#{Factory.next(:count)}"}
  r.association :solicitud
  r.association :usuario
  r.association :institucion
  r.descripcion { Faker::Lorem.sentence }
  r.association :tiporesolucion
  r.association :razontiporesolucion
  r.nueva_fecha nil
  r.informacion_publica true
  r.association :documentoclasificacion
end

Factory.define :tiporesolucion do |tr|
  tr.sequence(:nombre) {|tr| "tiporesolucion_#{Factory.next(:count)}"}
  tr.actualiza_fecha false
  tr.associtation :estado
end

Factory.define :via do |via|
  via.sequence(:nombre) {|via| "Via_#{Factory.next(:count)}"}
end

Factory.define :adjunto do |adjunto|
  adjunto.sequence(:numero) {|adjunto| "adjunto_#{Factory.next(:count)}"}
  adjunto.observaciones { Faker::Lorem.sentence }
  adjunto.association :usuario
  adjunto.association :proceso, :factory => :solicitud
  adjunto.informacion_publica true
  adjunto.archivo File.open(Rails.root + 'spec/fixtures/documentos/documento.doc')
end

Factory.define :fuente do |fuente|
  fuente.sequence(:nombre) {|fuente| "fuente_#{Factory.next(:count)}"}
end

Factory.define :solicitud do |s|
  s.association :usuario
  s.sequence(:codigo) {|n| "solicitud_#{Factory.next(:count)}"}
  s.association :institucion
  s.association :via
  s.fecha_creacion Date.today
  s.fecha_programada Date.today + 10
  s.fecha_entregada nil
  s.fecha_resolucion nil
  s.fecha_prorroga nil
  s.fecha_completada nil
  s.solicitante_nombre { Faker::Name.name }
  s.solicitante_identificacion 'XXX-123456'
  s.solicitante_direccion { Faker::Address.street_address }
  s.solicitante_telefonos { Faker::PhoneNumber.phone_number }
  s.solicitante_institucion 'Nombre Institucion'
  s.association :departamento
  s.association :municipio
  s.email { Faker::Internet.email }
  s.forma_entrega 'Escrita'
  s.observaciones { Faker::Lorem.sentence }
  s.ubicacion_url nil
  s.estado_id Solicitud::ESTADO_NORMAL
  s.textosolicitud { Faker::Lorem.sentence } 
  s.asignada false
  s.ano Date.today.year
  s.sequence(:numero) {|n| Factory.next(:count) }
  s.association :profesion
  s.association :genero
  s.association :rangoedad
  s.association :clasificacion
  s.dias_respuesta nil
  s.dias_prorroga nil
  s.motivonegativa_id nil
  s.motivoprorroga_id nil
  s.informacion_publica true
  s.origen_id Solicitud::ORIGEN_DEFAULT
  s.association :documentoclasificacion
end

Factory.define :tipomensaje do |tm|
  tm.sequence(:nombre) {|tm| "tipomensaje_#{Factory.next(:count)}"}
end

Factory.define :actividad do |actividad|
  actividad.association :institucion
  actividad.association :usuario
  actividad.fecha_asignacion Date.today
  actividad.estado_id Actividad::ESTADO_ACTIVA
  actividad.fecha_resolucion nil
  actividad.association :solicitud
  actividad.textoactividad 'No Disponible'
end

Factory.define :feriado do |f|
  f.sequence(:nombre) {|f| "feriado_#{Factory.next(:count)}"}
  f.dia 1
  f.mes 1
  f.institucion_id Institucion::ESTADO_GUATEMALA
  f.tipoferiado_id Feriado::TIPO_NACIONAL
  f.fecha Date.new(Date.today.year,1,1)
end

Factory.define :idioma do |i|
  i.sequence(:nombre) {|i| "idioma_#{Factory.next(:count)}"}
end
