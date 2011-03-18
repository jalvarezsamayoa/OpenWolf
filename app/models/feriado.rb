class Feriado < ActiveRecord::Base
  TIPO_NACIONAL = 1
  TIPO_LOCAL = 2
  TIPOS = [["Nacional", 1], ["Local", 2]]

  validates :nombre, :uniqueness => true, :presence => true
  validates :dia, :presence => true
  validates :mes, :presence => true
  validates :tipoferiado_id, :presence => true
  validates :institucion, :associated => true
  
  belongs_to :institucion

  before_validation :cleanup

  default_scope :order => "feriados.mes asc, feriados.dia asc"
  scope :nacional, where("tipoferiado_id = ?",TIPO_NACIONAL)
  scope :local, where("tipoferiado_id = ?",TIPO_LOCAL)
  
  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(feriados.nombre) like ?", valor )
    end
  }

  scope :por_institucion, lambda {|institucion_id|
    where("institucion_id = ?",institucion_id)
  }

  scope :en_fecha, lambda {|fecha|
    fecha = fecha.tr('/','-').to_date unless desde.class == Date
    a_fecha = [fecha.year, fecha.month, fecha.day]
    where("dia = ? and mes = ?",a_fecha[2], a_fecha[1])
  }

  scope :entre_fechas, lambda {|desde, hasta|
    desde = desde.tr('/','-').to_date unless desde.class == Date
    hasta = hasta.tr('/','-').to_date unless hasta.class == Date

    if desde.year == hasta.year
      where("fecha between ? and ?", desde, hasta)
    else
      ultimo_dia_ano = Date.civil(desde.year,12,31)
      primer_dia_ano = Date.civil(desde.year,1,1)
      hasta = (hasta << 12)
      where("(fecha between ? and ?) or (fecha between ? and ?)", desde, ultimo_dia_ano, primer_dia_ano, hasta)
    end
  }
  

  def tipo_feriado
    return 'Nacional' if tipoferiado_id == TIPO_NACIONAL
    'Local'
  end

  # indica si hay feriado en una fecha para una institucion
  def self.hay_feriado?(opts = {})
    return false if opts.nil?

    opts[:fecha] = Date.today if opts[:fecha].nil?
    opts[:institucion_id] = Institucion::ESTADO_GUATEMALA if opts[:institucion_id].nil?

    #verficamos feriados
    feriado = Feriado.por_institucion(opts[:institucion_id]).en_fecha(opts[:fecha]).limit(1)

    l_hay_feriado  = ((feriado.nil? or feriado.empty?) ? false : true)

    return l_hay_feriado
  end

  def es_dia_laboral?(hoy = nil)
    hoy = Date.civil(Date.today.year,self.mes,self.dia) if hoy.nil?
    l_finsemana = (hoy.wday == 0 or hoy.wday == 6)
    return !l_finsemana
  end
  

  private

  def cleanup
    self.fecha = Date.civil(Date.today.year, self.mes, self.dia)
    
    if self.tipoferiado_id == TIPO_NACIONAL
      self.institucion_id = Institucion::ESTADO_GUATEMALA
    end      
  end
  
end
