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
    fecha = fecha.tr('/','-').to_date unless fecha.class == Date
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


  # modifica una fecha hasta retornar un dia laborarl
  def self.obtener_fecha_valida(d_fecha_entrega, institucion_id)
    logger.debug { "Obteniendo fecha valida" }
    
    #es la ultima fecha feriado nacional
    logger.debug { "Verificando feriado nacional" }
    feriado_nacional = Feriado.hay_feriado?({:fecha => d_fecha_entrega})
    if feriado_nacional == true
      logger.debug { "Hay feriado, recalculando..." }
      d_fecha_entrega += 1.day

      d_fecha_entrega = self.obtener_fecha_valida(d_fecha_entrega, institucion_id)
    end

    #es la ultima fecha feriado local
    logger.debug { "Verificando feriado local" }
    feriado_local = Feriado.hay_feriado?({:fecha => d_fecha_entrega, :institucion_id => institucion_id})
    if feriado_local == true
      logger.debug { "Hay feriado recalculando..." }
      d_fecha_entrega += 1.day
      
      d_fecha_entrega = self.obtener_fecha_valida(d_fecha_entrega, institucion_id)
    end

    # verificamos que la nueve fecha sea dia laboral
    logger.debug { "Verificando dia sabado" }
    if d_fecha_entrega.wday == 6
      logger.debug { "Es sabado, recalculando.." }
      d_fecha_entrega += 1.day
      d_fecha_entrega = self.obtener_fecha_valida(d_fecha_entrega, institucion_id)
    end

    logger.debug { "Verificando dia domingo" }
    if d_fecha_entrega.wday == 0
      logger.debug { "Es domingo, recalculando..." }
      d_fecha_entrega += 1.day
      d_fecha_entrega = self.obtener_fecha_valida(d_fecha_entrega, institucion_id)
    end

    logger.debug { "Fecha valida obtenida" }
    return d_fecha_entrega
  end
  

  def es_dia_laboral?(hoy = nil)
    hoy = Date.civil(Date.today.year,self.mes,self.dia) if hoy.nil?
    l_finsemana = (hoy.wday == 0 or hoy.wday == 6)
    return !l_finsemana
  end
  

  #calcula los dias calendario de respuesta
  def self.calcular_dias_no_laborales(opts = {})   
    opts[:fecha] = Date.today if opts[:fecha].nil?
    opts[:dias] = 10 if opts[:dias].nil?

    fecha = opts[:fecha]
    dias = opts[:dias]
    
    #removermos dias no habiles
    dias_no_laborales = 0
    dias.times do |i|

      dia = (fecha + i)
      # es fin de semana
      if (dia.wday == 0 or dia.wday == 6)
        dias_no_laborales += 1
      else
        
        # es feriado global
        if Feriado.hay_feriado?(:fecha => dia,
                                :institucion_id => Institucion::ESTADO_GUATEMALA)
          dias_no_laborales += 1
        end

        # es feriado local
        unless opts[:institucion_id].nil?        
          if Feriado.hay_feriado?(:fecha => dia,
                                  :institucion_id => opts[:institucion_id])
            dias_no_laborales += 1
          end
        end
        
      end #(6..7)      
    end #dias.times

    return dias_no_laborales
  end #self.calcular_dias_no_laborales
  
  private

  def cleanup
    self.fecha = Date.civil(Date.today.year, self.mes, self.dia)
    
    if self.tipoferiado_id == TIPO_NACIONAL
      self.institucion_id = Institucion::ESTADO_GUATEMALA
    end      
  end
  
end
# == Schema Information
#
# Table name: feriados
#
#  id             :integer         not null, primary key
#  nombre         :string(255)     not null
#  dia            :integer         default(1), not null
#  mes            :integer         default(1), not null
#  institucion_id :integer         default(1), not null
#  tipoferiado_id :integer         default(1), not null
#  created_at     :datetime
#  updated_at     :datetime
#  fecha          :date
#

