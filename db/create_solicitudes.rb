# Creacion de Solicitudes de Ejemplo
class Time
  def self.random(years_back=5)
    if years_back == 0
      year = Time.now.year
    else
      year = Time.now.year - rand(years_back)
    end
    if year == Time.now.year
      month = rand(Time.now.month) + 1
    else
      month = rand(12) + 1
    end

    day = rand(31) + 1
    Time.local(year, month, day)
  end
end

# crear N solicitudes para una institucion
class GeneradorSolicitudes

  NUEVA = 1
  ASIGNADA = 2
  CONSEGUIMIENTO = 3
  COMPLETADA = 4
  CONRESOLUCION = 5
  CONPRORROGA = 6
  DENEGADA = 7
  
  def initialize
    @departamentos = get_ids(Departamento)
    @profesiones = get_ids(Profesion)
    @generos = get_ids(Genero)
    @rangosedad = get_ids(Rangoedad)
    @clasificaciones = get_ids(Clasificacion)
    @vias = get_ids(Via)

    @usuarios = [Usuario.find_by_username('superudip'),
                Usuario.find_by_username('test')]


    @enlaces = get_ids(Usuario)
  end

  def crear_solicitud(accion = NUEVA)

    d = Departamento.find(get_element(@departamentos))

    #crear nueva solicitud
    usuario = @usuarios[rand(2)]
    
    s = Solicitud.new(:usuario_id => usuario.id,
                      :institucion_id => usuario.institucion_id,
                      :solicitante_nombre => Faker::Name.name,
                      :solicitante_direccion => Faker::Address.street_address,
                      :solicitante_telefonos => Faker::PhoneNumber.phone_number,
                      :departamento_id => d.id,
                      :municipio_id => d.municipios.first.id,
                      :email => Faker::Internet.free_email,
                      :observaciones => Faker::Lorem.paragraph,
                      :ubicacion_url => Faker::Internet.domain_name,
                      :textosolicitud => Faker::Lorem.paragraph,
                      :profesion_id => get_element(@profesiones),
                      :genero_id => get_element(@generos),
                      :rangoedad_id => get_element(@rangosedad),
                      :clasificacion_id => get_element(@clasificaciones),
                      :via_id => get_element(@vias),
                      :fecha_creacion => Time.random(0),
                      :dont_send_email => true)

    s.save!

    if accion >= ASIGNADA
      #asignar solicitud
      s.actividades << Actividad.new( :institucion_id => s.institucion_id,
                                      :usuario_id => get_element(@enlaces),
                                      :fecha_asignacion => s.fecha_creacion, 
                                      :textoactividad => Faker::Lorem.paragraph,
                                      :estado_id => 1,
                                      :dont_send_email => true)
    end

    if accion >= CONSEGUIMIENTO
      #dar seguimiento a asginaciones
      s.actividades.each do |a|
        seg = Seguimiento.new(  :actividad_id => a.id,
                                :institucion_id => a.institucion_id,
                                :usuario_id => a.usuario_id,
                                :fecha_creacion => a.fecha_asignacion,
                                :textoseguimiento => Faker::Lorem.paragraph,
                                :informacion_publica => true)

        if accion >= COMPLETADA
          a.marcar_como_terminada

          if accion >= CONRESOLUCION
            s.resoluciones << Resolucion.new(:usuario_id => s.usuario_id,
                                             :institucion_id => s.institucion_id,
                                             :descripcion => Faker::Lorem.paragraph,
                                             :tiporesolucion_id => 1,
                                             :razontiporesolucion_id => 1,
                                             :nueva_fecha => nil,
                                             :informacion_publica => true,
                                             :dont_send_email => true)
            s.save!
          end #resolucion
          
        end #completa
      end
    end


    
  end
  
  private

  def get_ids(table)
    table.find(:all, :select => "id")
  end

  def get_element(element)
    max = element[element.size - 1].id
    rand(max)+1
  end

  
end


#crear solicitud para institucion
gs = GeneradorSolicitudes.new
(rand(50)+1).times do
  gs.crear_solicitud(GeneradorSolicitudes::NUEVA)
end
(rand(50)+1).times do
  gs.crear_solicitud(GeneradorSolicitudes::ASIGNADA)
end
(rand(50)+1).times do
  gs.crear_solicitud(GeneradorSolicitudes::CONSEGUIMIENTO)
end
(rand(50)+1).times do
  gs.crear_solicitud(GeneradorSolicitudes::COMPLETADA)
end
(rand(50)+1).times do
  gs.crear_solicitud(GeneradorSolicitudes::CONRESOLUCION)
end
