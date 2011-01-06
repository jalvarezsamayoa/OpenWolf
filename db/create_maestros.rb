# -*- coding: utf-8 -*-

require 'active_record/fixtures'
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "departamentos")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "municipios")  
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "profesiones")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures","instituciones")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "generos")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "rangosedad")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "clasificaciones")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "motivosnegativa")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "motivosprorroga")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "estados")
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "usuarios")

vias = Via.create([ {:nombre => 'Escrita'},
                    {:nombre => 'Verbal'},
                    {:nombre => 'Correo Electronico'},
                    {:nombre => 'Internet'},
                    {:nombre => 'Otros'} ])


tiposresoluciones = Tiporesolucion.create([ {:nombre => 'Entrega Total',
                                              :actualiza_fecha => false,
                                              :estado_id => 3},
                                            {:nombre => 'Entrega Parcial',
                                              :actualiza_fecha => false,
                                              :estado_id => 4},
                                            {:nombre => 'Negativa',
                                              :actualiza_fecha => false,
                                              :estado_id => 5},
                                            {:nombre => 'Prorroga',
                                              :actualiza_fecha => true,
                                              :estado_id => 2}
                                          ])

razonesresoluciones = Razontiporesolucion.create([{:nombre => 'Entrega a ciudadano.',
                                                    :tiporesolucion_id => 1,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Necesita Aclaracion.',
                                                    :tiporesolucion_id => 2,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Falta de tiempo.',
                                                    :tiporesolucion_id => 2,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Falta de aclaración.',
                                                    :tiporesolucion_id => 3,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Omisión del solicitante.',
                                                    :tiporesolucion_id => 3,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Información inexistente.',
                                                    :tiporesolucion_id => 3,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Información reservada.',
                                                    :tiporesolucion_id => 3,
                                                    :informacion_publica => true},
                                                  {:nombre => 'Información clasificada.',
                                                    :tiporesolucion_id => 3,
                                                    :informacion_publica => false},
                                                  {:nombre => 'Volumen de la información.',
                                                    :tiporesolucion_id => 4,
                                                    :informacion_publica => false},
                                                  {:nombre => 'Extensión de la respuesta.',
                                                    :tiporesolucion_id => 4,
                                                    :informacion_publica => true},
                                                 ])

sentidosresolucion = Sentidoresolucion.create([ { :nombre => 'Ninguna' },
                                                { :nombre => 'Confirma' },
                                                { :nombre => 'Revoca' },
                                                { :nombre => 'Modifica' }
                                              ])


tipomensajes = Tipomensaje.create([ {:nombre => 'Memo'},
                                     {:nombre => 'Carta'},
                                     {:nombre => 'Invitacion Evento'} ])


#######################################
# Maestros de Mensajeria y Archivistica
#######################################

fondo = Documentocategoria.create(:nombre => "Fondos")
subfondo = Documentocategoria.create(:nombre => "Subfondos")
serie = Documentocategoria.create(:nombre => "Series")

hemeroteca = Documentocategoria.create(:nombre => "Hemeroteca")
digital = Documentocategoria.create(:nombre => "Medio Digitales")
microfilm = Documentocategoria.create(:nombre => "Microfilm")
negativos = Documentocategoria.create(:nombre => "Negativos de Fotografías")

subfondo.move_to_child_of(fondo)
serie.move_to_child_of(subfondo)

clasificaciones_documentales = Documentoclasificacion.create([ {:nombre => "Oficio", :documentocategoria_id => serie.id, :codigo => "05"},
                                                               {:nombre => "Providencia", :documentocategoria_id => serie.id, :codigo => "06"},
                                                               {:nombre => "Carta", :documentocategoria_id => serie.id, :codigo => "07"},
                                                               {:nombre => "Memorando", :documentocategoria_id => serie.id, :codigo => "08" },
                                                               {:nombre => "Circular", :documentocategoria_id => serie.id, :codigo => "09"},
                                                               {:nombre => "Acta", :documentocategoria_id => serie.id, :codigo => "10"},
                                                               {:nombre => "Acuerdo", :documentocategoria_id => serie.id, :codigo => "11"},
                                                               {:nombre => "Contrato", :documentocategoria_id => serie.id, :codigo => "12"},
                                                               {:nombre => "Convenio", :documentocategoria_id => serie.id, :codigo => "13"},
                                                               {:nombre => "Informe", :documentocategoria_id => serie.id, :codigo => "14"},
                                                               {:nombre => "Agenda de Actividades", :documentocategoria_id => serie.id, :codigo => "15"},
                                                               {:nombre => "Proyecto", :documentocategoria_id => serie.id, :codigo => "16"},
                                                               {:nombre => "Revista", :documentocategoria_id => hemeroteca.id, :codigo => "17"},
                                                               {:nombre => "Ley", :documentocategoria_id => hemeroteca.id, :codigo => "18"},
                                                               {:nombre => "Recorte de Prensa", :documentocategoria_id => hemeroteca.id, :codigo => "19"},
                                                             ])
