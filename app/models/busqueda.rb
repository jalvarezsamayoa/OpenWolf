class Busqueda
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  ATTRIBUTES = [:institucion_id, :fecha_desde, :fecha_hasta, :q, \
                :solicitud_via, :solicitud_estado, :solicitud_tiempo, :filtrar, \
                :anuladas, :page].freeze

  ATTRIBUTES.each do |attr|
    attr_accessor attr
  end

  DEFAULTS = {
    "fecha_desde" => (Date.today - Date.today.yday + 1),
    "fecha_hasta" => Date.today  }

  def initialize(args = nil)

    args = args ? DEFAULTS.merge(args['busqueda']) : DEFAULTS

    ATTRIBUTES.each do |attr|
      if (args.key?(attr.to_s))
        instance_variable_set("@#{attr.to_s}", args[attr.to_s])
      end
    end

    super
  end

  def inspect
    ATTRIBUTES.inject({ }) do |h, attr|
      h[attr] = instance_variable_get("@#{attr}")
      h
    end
  end

  def persisted? ; false ; end;

  def solicitudes

    l_excluir_anuladas = false
    l_filtrar_tiempo_restante = false
    i_institucion_id = nil
    i_via_id = nil
    i_estado_id = nil


    l_excluir_anuladas = true if (self.anuladas.nil? or self.anuladas != true)
    l_filtrar_tiempo_restante = (self.solicitud_tiempo && !self.solicitud_tiempo.blank?)

    i_institucion_id = self.institucion_id if (self.institucion_id && !self.institucion_id.blank?)
    i_via_id = self.solicitud_via if (self.solicitud_via && !self.solicitud_via.blank?)
    i_estado_id = self.solicitud_estado if (self.solicitud_estado && !self.solicitud_estado.blank?)

    d_fechadesde = self.fecha_desde
    d_fechahasta = self.fecha_hasta


    #veficar si usuario intento enviar un solo entero
    # que seria el correlativo de la solicitud
    i_numero = nil
    if self.q
      unless self.q.include?('-')
        i_numero = self.q.to_i
        self.q = '' if i_numero > 0
      end
    end

    if l_filtrar_tiempo_restante
      case self.solicitud_tiempo
      when '0a3'
        desde = 0
        hasta = 3
      when '4a6'
        desde = 4
        hasta = 6
      when '7a9'
        desde = 7
        hasta = 9
      when '10'
        desde = 10
        hasta = 10
      when 'LATE'
        hasta = 11
        desde = 100000
      end

      d_fechaprogdesde = Date.today + desde
      d_fechaproghasta = Date.today + hasta
    end


    solicitudes = Solicitud.order('fecha_creacion desc')

    solicitudes = solicitudes.where(numero: i_numero) unless (i_numero.nil? or i_numero == 0)
    solicitudes = solicitudes.where(institucion_id: i_institucion_id) if i_institucion_id
    solicitudes = solicitudes.where(via_id: i_via_id) if i_via_id
    solicitudes = solicitudes.where(estado_id: i_estado_id) if i_estado_id
    solicitudes = solicitudes.where(fecha_creacion: d_fechadesde..d_fechahasta) if d_fechadesde
    solicitudes = solicitudes.where(fecha_programada: d_fechaprogdesde..d_fechaproghasta) if l_filtrar_tiempo_restante
    solicitudes = solicitudes.where(anulada: false) if l_excluir_anuladas
    solicitudes = solicitudes.text_search(self.q) unless (self.q.nil? or self.q.empty?)

    solicitudes = solicitudes.paginate(:page => self.page)
  end

end
