# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120313203152) do

  create_table "actividades", :force => true do |t|
    t.integer  "institucion_id",                  :null => false
    t.integer  "usuario_id",                      :null => false
    t.date     "fecha_asignacion",                :null => false
    t.text     "textoactividad",                  :null => false
    t.integer  "estado_id",        :default => 1, :null => false
    t.date     "fecha_resolucion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "solicitud_id",                    :null => false
  end

  add_index "actividades", ["estado_id"], :name => "index_actividades_on_estado_id"
  add_index "actividades", ["fecha_asignacion"], :name => "index_actividades_on_fecha_asignacion"
  add_index "actividades", ["fecha_resolucion"], :name => "index_actividades_on_fecha_resolucion"
  add_index "actividades", ["institucion_id"], :name => "index_actividades_on_institucion_id"
  add_index "actividades", ["solicitud_id"], :name => "index_actividades_on_solicitud_id"
  add_index "actividades", ["usuario_id"], :name => "index_actividades_on_usuario_id"

  create_table "adjuntos", :force => true do |t|
    t.string   "numero",                                 :null => false
    t.text     "observaciones"
    t.integer  "usuario_id",                             :null => false
    t.integer  "proceso_id",                             :null => false
    t.string   "proceso_type",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.boolean  "informacion_publica",  :default => true, :null => false
  end

  add_index "adjuntos", ["informacion_publica"], :name => "index_adjuntos_on_informacion_publica"
  add_index "adjuntos", ["numero"], :name => "index_adjuntos_on_numero"
  add_index "adjuntos", ["proceso_id"], :name => "index_adjuntos_on_proceso_id"
  add_index "adjuntos", ["proceso_type"], :name => "index_adjuntos_on_proceso_type"
  add_index "adjuntos", ["usuario_id"], :name => "index_adjuntos_on_usuario_id"

  create_table "archivos", :force => true do |t|
    t.string   "nombre",         :null => false
    t.integer  "institucion_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archivos", ["institucion_id"], :name => "index_archivos_on_institucion_id"

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",        :default => 0
    t.string   "comment"
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "clasificaciones", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "departamentos", :force => true do |t|
    t.string   "nombre",      :null => false
    t.string   "abreviatura", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentocategorias", :force => true do |t|
    t.string   "nombre"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documentocategorias", ["lft"], :name => "index_documentocategorias_on_lft"
  add_index "documentocategorias", ["parent_id"], :name => "index_documentocategorias_on_parent_id"
  add_index "documentocategorias", ["rgt"], :name => "index_documentocategorias_on_rgt"

  create_table "documentoclasificaciones", :force => true do |t|
    t.string   "nombre"
    t.integer  "documentocategoria_id"
    t.string   "codigo"
    t.string   "plantilla"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documentoclasificaciones", ["codigo"], :name => "index_documentoclasificaciones_on_codigo"
  add_index "documentoclasificaciones", ["documentocategoria_id"], :name => "index_documentoclasificaciones_on_documentocategoria_id"

  create_table "documentodestinatarios", :force => true do |t|
    t.integer "documento_id",                      :null => false
    t.integer "copia_id"
    t.integer "usuario_id",                        :null => false
    t.boolean "original",                          :null => false
    t.integer "documentoestado_id", :default => 1, :null => false
    t.integer "institucion_id",                    :null => false
    t.string  "puesto"
    t.string  "departamento"
  end

  add_index "documentodestinatarios", ["copia_id"], :name => "index_documentodestinatarios_on_copia_id"
  add_index "documentodestinatarios", ["documento_id"], :name => "index_documentodestinatarios_on_documento_id"
  add_index "documentodestinatarios", ["documentoestado_id"], :name => "index_documentodestinatarios_on_documentoestado_id"
  add_index "documentodestinatarios", ["institucion_id"], :name => "index_documentodestinatarios_on_institucion_id"
  add_index "documentodestinatarios", ["original"], :name => "index_documentodestinatarios_on_original"
  add_index "documentodestinatarios", ["usuario_id"], :name => "index_documentodestinatarios_on_usuario_id"

  create_table "documentos", :force => true do |t|
    t.string   "numero",                                   :null => false
    t.integer  "origen_id",                 :default => 1, :null => false
    t.integer  "documentoclasificacion_id",                :null => false
    t.integer  "documentocategoria_id",                    :null => false
    t.date     "fecha_documento",                          :null => false
    t.integer  "autor_id",                                 :null => false
    t.string   "asunto",                                   :null => false
    t.text     "texto"
    t.date     "fecha_recepcion"
    t.string   "remitente_nombre"
    t.text     "remitente_direccion"
    t.string   "remitente_telefonos"
    t.string   "remitente_email"
    t.integer  "estado_envio_id",           :default => 1, :null => false
    t.boolean  "original",                                 :null => false
    t.integer  "usuario_id",                               :null => false
    t.integer  "institucion_id",                           :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "archivo_id"
  end

  add_index "documentos", ["archivo_id"], :name => "index_documentos_on_archivo_id"
  add_index "documentos", ["autor_id"], :name => "index_documentos_on_autor_id"
  add_index "documentos", ["documentocategoria_id"], :name => "index_documentos_on_documentocategoria_id"
  add_index "documentos", ["documentoclasificacion_id"], :name => "index_documentos_on_documentoclasificacion_id"
  add_index "documentos", ["estado_envio_id"], :name => "index_documentos_on_estado_envio_id"
  add_index "documentos", ["fecha_documento"], :name => "index_documentos_on_fecha_documento"
  add_index "documentos", ["fecha_recepcion"], :name => "index_documentos_on_fecha_recepcion"
  add_index "documentos", ["institucion_id"], :name => "index_documentos_on_institucion_id"
  add_index "documentos", ["lft"], :name => "index_documentos_on_lft"
  add_index "documentos", ["numero"], :name => "index_documentos_on_numero"
  add_index "documentos", ["origen_id"], :name => "index_documentos_on_origen_id"
  add_index "documentos", ["original"], :name => "index_documentos_on_original"
  add_index "documentos", ["parent_id"], :name => "index_documentos_on_parent_id"
  add_index "documentos", ["rgt"], :name => "index_documentos_on_rgt"
  add_index "documentos", ["usuario_id"], :name => "index_documentos_on_usuario_id"

  create_table "documentotraslados", :force => true do |t|
    t.integer  "institucion_id",                               :null => false
    t.integer  "usuario_id",                                   :null => false
    t.integer  "destinatario_id",                              :null => false
    t.integer  "documento_id",                                 :null => false
    t.integer  "documento_destinatario_id",                    :null => false
    t.boolean  "original",                  :default => false
    t.integer  "estado_entrega_id",         :default => 1,     :null => false
    t.datetime "fecha_envio"
    t.datetime "fecha_respuesta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "descripcion"
  end

  add_index "documentotraslados", ["destinatario_id"], :name => "index_documentotraslados_on_destinatario_id"
  add_index "documentotraslados", ["documento_destinatario_id"], :name => "index_documentotraslados_on_documento_destinatario_id"
  add_index "documentotraslados", ["documento_id"], :name => "index_documentotraslados_on_documento_id"
  add_index "documentotraslados", ["estado_entrega_id"], :name => "index_documentotraslados_on_estado_entrega_id"
  add_index "documentotraslados", ["fecha_envio"], :name => "index_documentotraslados_on_fecha_envio"
  add_index "documentotraslados", ["fecha_respuesta"], :name => "index_documentotraslados_on_fecha_respuesta"
  add_index "documentotraslados", ["institucion_id"], :name => "index_documentotraslados_on_institucion_id"
  add_index "documentotraslados", ["original"], :name => "index_documentotraslados_on_original"
  add_index "documentotraslados", ["usuario_id"], :name => "index_documentotraslados_on_usuario_id"

  create_table "estados", :force => true do |t|
    t.string   "nombre",                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "final",          :default => false
    t.boolean  "puede_entregar", :default => false
    t.integer  "modulo_id",      :default => 1
  end

  add_index "estados", ["final"], :name => "index_estados_on_final"
  add_index "estados", ["modulo_id"], :name => "index_estados_on_modulo_id"
  add_index "estados", ["puede_entregar"], :name => "index_estados_on_puede_entregar"

  create_table "feriados", :force => true do |t|
    t.string   "nombre",                        :null => false
    t.integer  "dia",            :default => 1, :null => false
    t.integer  "mes",            :default => 1, :null => false
    t.integer  "institucion_id", :default => 1, :null => false
    t.integer  "tipoferiado_id", :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "fecha"
  end

  add_index "feriados", ["dia"], :name => "index_feriados_on_dia"
  add_index "feriados", ["fecha"], :name => "index_feriados_on_fecha"
  add_index "feriados", ["institucion_id"], :name => "index_feriados_on_institucion_id"
  add_index "feriados", ["mes"], :name => "index_feriados_on_mes"
  add_index "feriados", ["tipoferiado_id"], :name => "index_feriados_on_tipoferiado_id"

  create_table "fuentes", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "idiomas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instituciones", :force => true do |t|
    t.string   "nombre",                                          :null => false
    t.integer  "tipoinstitucion_id",                              :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo",                 :default => "9999-9999", :null => false
    t.string   "abreviatura",            :default => "NA",        :null => false
    t.string   "direccion"
    t.string   "telefono"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "activa",                 :default => false
    t.boolean  "usasolicitudesprivadas", :default => false
    t.string   "unidad_ejecutora"
    t.string   "entidad"
    t.string   "webpage"
    t.string   "email"
  end

  add_index "instituciones", ["abreviatura"], :name => "index_instituciones_on_abreviatura"
  add_index "instituciones", ["activa"], :name => "index_instituciones_on_activa"
  add_index "instituciones", ["codigo"], :name => "index_instituciones_on_codigo"
  add_index "instituciones", ["entidad"], :name => "index_instituciones_on_entidad"
  add_index "instituciones", ["lft"], :name => "index_instituciones_on_lft"
  add_index "instituciones", ["parent_id"], :name => "index_instituciones_on_parent_id"
  add_index "instituciones", ["rgt"], :name => "index_instituciones_on_rgt"
  add_index "instituciones", ["tipoinstitucion_id"], :name => "index_instituciones_on_tipoinstitucion_id"
  add_index "instituciones", ["unidad_ejecutora"], :name => "index_instituciones_on_unidad_ejecutora"

  create_table "motivosnegativa", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "motivosprorroga", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "municipios", :force => true do |t|
    t.string   "nombre",          :null => false
    t.integer  "departamento_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "municipios", ["departamento_id"], :name => "index_municipios_on_departamento_id"

  create_table "notas", :force => true do |t|
    t.integer  "proceso_id"
    t.string   "proceso_type"
    t.integer  "usuario_id"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "informacion_publica", :default => true, :null => false
  end

  add_index "notas", ["informacion_publica"], :name => "index_notas_on_informacion_publica"
  add_index "notas", ["proceso_id"], :name => "index_notas_on_proceso_id"
  add_index "notas", ["proceso_type"], :name => "index_notas_on_proceso_type"
  add_index "notas", ["usuario_id"], :name => "index_notas_on_usuario_id"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "profesiones", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "puestos", :force => true do |t|
    t.string   "nombre",         :null => false
    t.integer  "institucion_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "puestos", ["institucion_id"], :name => "index_puestos_on_institucion_id"

  create_table "rangosedad", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "razonestiposresoluciones", :force => true do |t|
    t.string   "nombre",                                :null => false
    t.integer  "tiporesolucion_id",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "informacion_publica", :default => true, :null => false
  end

  add_index "razonestiposresoluciones", ["informacion_publica"], :name => "index_razonestiposresoluciones_on_informacion_publica"
  add_index "razonestiposresoluciones", ["tiporesolucion_id"], :name => "index_razonestiposresoluciones_on_tiporesolucion_id"

  create_table "recursosrevision", :force => true do |t|
    t.integer  "solicitud_id"
    t.date     "fecha_presentacion"
    t.date     "fecha_notificacion"
    t.date     "fecha_resolucion"
    t.text     "descripcion"
    t.integer  "sentidoresolucion_id"
    t.integer  "institucion_id"
    t.integer  "usuario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "numero"
    t.integer  "documentoclasificacion_id", :default => 3
  end

  add_index "recursosrevision", ["documentoclasificacion_id"], :name => "index_recursosrevision_on_documentoclasificacion_id"
  add_index "recursosrevision", ["institucion_id"], :name => "index_recursosrevision_on_institucion_id"
  add_index "recursosrevision", ["numero"], :name => "index_recursosrevision_on_numero"
  add_index "recursosrevision", ["sentidoresolucion_id"], :name => "index_recursosrevision_on_sentidoresolucion_id"
  add_index "recursosrevision", ["solicitud_id"], :name => "index_recursosrevision_on_solicitud_id"
  add_index "recursosrevision", ["usuario_id"], :name => "index_recursosrevision_on_usuario_id"

  create_table "resoluciones", :force => true do |t|
    t.string   "numero",                                      :null => false
    t.integer  "solicitud_id",                                :null => false
    t.integer  "usuario_id",                                  :null => false
    t.integer  "institucion_id",                              :null => false
    t.text     "descripcion",                                 :null => false
    t.integer  "tiporesolucion_id",                           :null => false
    t.integer  "razontiporesolucion_id",                      :null => false
    t.date     "nueva_fecha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "informacion_publica",       :default => true, :null => false
    t.integer  "documentoclasificacion_id", :default => 2
    t.date     "fecha"
    t.date     "fecha_notificacion"
  end

  add_index "resoluciones", ["documentoclasificacion_id"], :name => "index_resoluciones_on_documentoclasificacion_id"
  add_index "resoluciones", ["fecha"], :name => "index_resoluciones_on_fecha"
  add_index "resoluciones", ["fecha_notificacion"], :name => "index_resoluciones_on_fecha_notificacion"
  add_index "resoluciones", ["informacion_publica"], :name => "index_resoluciones_on_informacion_publica"
  add_index "resoluciones", ["institucion_id"], :name => "index_resoluciones_on_institucion_id"
  add_index "resoluciones", ["numero"], :name => "index_resoluciones_on_numero"
  add_index "resoluciones", ["razontiporesolucion_id"], :name => "index_resoluciones_on_razontiporesolucion_id"
  add_index "resoluciones", ["solicitud_id"], :name => "index_resoluciones_on_solicitud_id"
  add_index "resoluciones", ["tiporesolucion_id"], :name => "index_resoluciones_on_tiporesolucion_id"
  add_index "resoluciones", ["usuario_id"], :name => "index_resoluciones_on_usuario_id"

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["authorizable_id"], :name => "index_roles_on_authorizable_id"
  add_index "roles", ["authorizable_type"], :name => "index_roles_on_authorizable_type"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_usuarios", ["role_id"], :name => "index_roles_usuarios_on_role_id"
  add_index "roles_usuarios", ["usuario_id"], :name => "index_roles_usuarios_on_usuario_id"

  create_table "seguimientos", :force => true do |t|
    t.integer  "actividad_id",                           :null => false
    t.integer  "institucion_id",                         :null => false
    t.integer  "usuario_id",                             :null => false
    t.date     "fecha_creacion",                         :null => false
    t.text     "textoseguimiento",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.boolean  "informacion_publica",  :default => true, :null => false
  end

  add_index "seguimientos", ["actividad_id"], :name => "index_seguimientos_on_actividad_id"
  add_index "seguimientos", ["fecha_creacion"], :name => "index_seguimientos_on_fecha_creacion"
  add_index "seguimientos", ["informacion_publica"], :name => "index_seguimientos_on_informacion_publica"
  add_index "seguimientos", ["institucion_id"], :name => "index_seguimientos_on_institucion_id"
  add_index "seguimientos", ["usuario_id"], :name => "index_seguimientos_on_usuario_id"

  create_table "sentidosresolucion", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "solicitudes", :force => true do |t|
    t.integer  "usuario_id",                                                   :null => false
    t.string   "codigo",                      :default => "XXXXX-999999-9999", :null => false
    t.integer  "institucion_id",                                               :null => false
    t.integer  "tiposolicitud_id",            :default => 1
    t.integer  "via_id",                      :default => 1,                   :null => false
    t.date     "fecha_creacion"
    t.date     "fecha_programada"
    t.date     "fecha_entregada"
    t.date     "fecha_resolucion"
    t.date     "fecha_prorroga"
    t.date     "fecha_completada"
    t.string   "solicitante_nombre",                                           :null => false
    t.string   "solicitante_identificacion"
    t.string   "solicitante_direccion"
    t.string   "solicitante_telefonos"
    t.string   "solicitante_institucion"
    t.integer  "departamento_id"
    t.integer  "municipio_id"
    t.string   "email"
    t.string   "forma_entrega"
    t.text     "observaciones"
    t.string   "ubicacion_url"
    t.integer  "estado_id",                   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "textosolicitud"
    t.boolean  "asignada"
    t.integer  "ano",                                                          :null => false
    t.integer  "numero",                                                       :null => false
    t.integer  "profesion_id"
    t.integer  "genero_id"
    t.integer  "rangoedad_id"
    t.integer  "clasificacion_id"
    t.integer  "dias_respuesta"
    t.integer  "dias_prorroga"
    t.integer  "motivonegativa_id"
    t.integer  "motivoprorroga_id"
    t.boolean  "informacion_publica",         :default => true,                :null => false
    t.integer  "origen_id",                   :default => 1
    t.integer  "documentoclasificacion_id",   :default => 1
    t.integer  "idioma_id",                   :default => 12,                  :null => false
    t.boolean  "anulada",                     :default => false
    t.integer  "tiempo_respuesta",            :default => 0
    t.integer  "tiempo_respuesta_calendario", :default => 0
    t.boolean  "reserva_temporal",            :default => false
  end

  add_index "solicitudes", ["ano"], :name => "index_solicitudes_on_ano"
  add_index "solicitudes", ["anulada"], :name => "index_solicitudes_on_anulada"
  add_index "solicitudes", ["clasificacion_id"], :name => "index_solicitudes_on_clasificacion_id"
  add_index "solicitudes", ["codigo"], :name => "index_solicitudes_on_codigo"
  add_index "solicitudes", ["departamento_id"], :name => "index_solicitudes_on_departamento_id"
  add_index "solicitudes", ["documentoclasificacion_id"], :name => "index_solicitudes_on_documentoclasificacion_id"
  add_index "solicitudes", ["estado_id"], :name => "index_solicitudes_on_estado_id"
  add_index "solicitudes", ["fecha_completada"], :name => "index_solicitudes_on_fecha_completada"
  add_index "solicitudes", ["fecha_creacion"], :name => "index_solicitudes_on_fecha_creacion"
  add_index "solicitudes", ["fecha_entregada"], :name => "index_solicitudes_on_fecha_entregada"
  add_index "solicitudes", ["fecha_programada"], :name => "index_solicitudes_on_fecha_programada"
  add_index "solicitudes", ["fecha_prorroga"], :name => "index_solicitudes_on_fecha_prorroga"
  add_index "solicitudes", ["fecha_resolucion"], :name => "index_solicitudes_on_fecha_resolucion"
  add_index "solicitudes", ["genero_id"], :name => "index_solicitudes_on_genero_id"
  add_index "solicitudes", ["idioma_id"], :name => "index_solicitudes_on_idioma_id"
  add_index "solicitudes", ["informacion_publica"], :name => "index_solicitudes_on_informacion_publica"
  add_index "solicitudes", ["institucion_id"], :name => "index_solicitudes_on_institucion_id"
  add_index "solicitudes", ["motivonegativa_id"], :name => "index_solicitudes_on_motivonegativa_id"
  add_index "solicitudes", ["motivoprorroga_id"], :name => "index_solicitudes_on_motivoprorroga_id"
  add_index "solicitudes", ["municipio_id"], :name => "index_solicitudes_on_municipio_id"
  add_index "solicitudes", ["numero"], :name => "index_solicitudes_on_numero"
  add_index "solicitudes", ["origen_id"], :name => "index_solicitudes_on_origen_id"
  add_index "solicitudes", ["rangoedad_id"], :name => "index_solicitudes_on_rangoedad_id"
  add_index "solicitudes", ["reserva_temporal"], :name => "index_solicitudes_on_reserva_temporal"
  add_index "solicitudes", ["solicitante_institucion"], :name => "index_solicitudes_on_solicitante_institucion"
  add_index "solicitudes", ["solicitante_nombre"], :name => "index_solicitudes_on_solicitante_nombre"
  add_index "solicitudes", ["tiempo_respuesta"], :name => "index_solicitudes_on_tiempo_respuesta"
  add_index "solicitudes", ["tiempo_respuesta_calendario"], :name => "index_solicitudes_on_tiempo_respuesta_calendario"
  add_index "solicitudes", ["tiposolicitud_id"], :name => "index_solicitudes_on_tiposolicitud_id"
  add_index "solicitudes", ["usuario_id"], :name => "index_solicitudes_on_usuario_id"
  add_index "solicitudes", ["via_id"], :name => "index_solicitudes_on_via_id"

  create_table "temp_assets", :force => true do |t|
    t.integer  "institucion_id"
    t.integer  "usuario_id"
    t.text     "options"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
  end

  create_table "tipomensajes", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiposresoluciones", :force => true do |t|
    t.string   "nombre",                                          :null => false
    t.boolean  "actualiza_fecha",              :default => false
    t.integer  "estado_id",                    :default => 1,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "actualiza_fecha_notificacion", :default => false
    t.boolean  "positiva",                     :default => false
    t.string   "aliaspdh"
  end

  add_index "tiposresoluciones", ["positiva"], :name => "index_tiposresoluciones_on_positiva"

  create_table "usuarios", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "nombre"
    t.string   "cargo"
    t.integer  "puesto_id"
    t.integer  "institucion_id"
    t.boolean  "essupervisorarea"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.integer  "sign_in_count"
    t.integer  "failed_attempts"
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "genero",               :default => false
    t.date     "fecha_nacimiento"
    t.string   "direccion",            :default => "No Disponible", :null => false
    t.string   "telefonos",            :default => "No Disponible", :null => false
    t.string   "openid_identifier"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "activo",               :default => true
  end

  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email"
  add_index "usuarios", ["institucion_id"], :name => "index_usuarios_on_institucion_id"
  add_index "usuarios", ["openid_identifier"], :name => "index_usuarios_on_openid_identifier"
  add_index "usuarios", ["puesto_id"], :name => "index_usuarios_on_puesto_id"
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["unlock_token"], :name => "index_usuarios_on_unlock_token", :unique => true
  add_index "usuarios", ["username"], :name => "index_usuarios_on_username"

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

  create_table "vias", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worker_logs", :force => true do |t|
    t.text     "status"
    t.integer  "process_id"
    t.text     "last_error"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
