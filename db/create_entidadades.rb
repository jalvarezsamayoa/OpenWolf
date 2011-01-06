class CreateEntidades

  def initialize
    @root = root('ESTADO DE GUATEMALA','GT','GOBGT','','')
    @ejecutivo = poder(@root,'1113','EJECUTIVO','EJ','','')
    @legislativo = poder(@root,'1111','LEGISLATIVO','LE','','')
    @judicial = poder(@root,'1112','JUDICIAL','OJ','','')
    @autonomas = poder(@root,'4444','AUTONOMAS','AU','','')

  end

  def import

    FasterCSV.foreach("#{Rails.root}/db/fixtures/entidades.csv",
                      {:col_sep => ";", :headers => true}) do |e|


      tipo = e['tipo']
      poder = e['poder']
      entidad = e['entidad']
      unidad = e['unidad']
      nombre = e['nombre']
      codigo = entidad + ( unidad == '0' ? '' : '-' + unidad)


      case poder
      when '2'
        padre = @ejecutivo
      when '3'
        padre = @legislatiov
      when '4'
        padre = @judicial
      when '5'
        padre = @autonomas
      else
        raise "No hay poder valido #{e.inspect}"
      end
      
      case tipo
      when '3'   
        ministerio(padre, codigo, nombre, '', entidad, unidad)
      when '4'
        #verificar si padre existe
        new_padre = Institucion.find_by_codigo(entidad)
        padre = new_padre unless new_padre.nil?

        institucion(padre, nombre, codigo, '', entidad, unidad)
      end


    end    
  end
  
  def root(nombre, abreviatura, codigo, entidad, unidad)
    Institucion.create!(:nombre => nombre, :tipoinstitucion_id => 1, :codigo => codigo, :abreviatura => abreviatura, :entidad => entidad, :unidad_ejecutora => unidad)
  end

  def poder(root, codigo, nombre, abreviatura, entidad, unidad)  
    i = Institucion.create!(:nombre => nombre, :tipoinstitucion_id => 2, :codigo => codigo, :abreviatura => abreviatura, :entidad => entidad, :unidad_ejecutora => unidad)
    i.move_to_child_of(root)
    return i
  end

  def ministerio(root, codigo, nombre, abreviatura, entidad, unidad)  
    i = Institucion.create!(:nombre => nombre, :tipoinstitucion_id => 3, :codigo => codigo, :abreviatura => abreviatura, :entidad => entidad, :unidad_ejecutora => unidad)
    i.move_to_child_of(root)
    return i
  end

  def institucion(padre, nombre, codigo, abreviatura, entidad, unidad)
    i = Institucion.create!(:nombre => nombre, :tipoinstitucion_id => 4, :codigo => codigo, :abreviatura => abreviatura, :entidad => entidad, :unidad_ejecutora => unidad)
    i.move_to_child_of(padre)  
    return i
  end

  
end


ce = CreateEntidades.new
ce.import





# presidencia = ministerio(ejecutivo,'1113-0003','PRESIDENCIA DE LA REPUBLICA', 'PRES')
# mingob = ministerio(presidencia,'1113-0005','MININSTERIO DE GOBERNACION','MINGOB')
# minfin = ministerio(presidencia,'1113-0007','MINISTERIO DE FINANZAS PUBLICAS','MINFIN')
# mineduc = ministerio(presidencia,'1113-0008','MINISTERIO DE EDUCACION','MINEDUC')
# minpas = ministerio(presidencia,'1113-0009','MINISTERIO DE SALUD PUBLICA Y ASISTENCIA SOCIAL','MINSPAS')
# micivi = ministerio(presidencia,'1113-0013','MINISTERIO DE  COMUNICACIONES, INFRAESTRUCTURA Y VIVIENDA','MICIVI')
# micude = ministerio(presidencia,'1113-0015','MINISTERIO DE CULTURA Y DEPORTES','MICUDE')
# sodeej = ministerio(presidencia,'1113-0016','SECRETARIAS Y OTRAS DEPENDENCIAS DEL EJECUTIVO','SODEEJ')

# institucion(presidencia, 'VICEPRESIDENCIA DE LA REPUBLICA', 'VICE')
# institucion(presidencia, 'SECRETARIA DE ASUNTOS ADM.Y DE SEG.DE LA PRESIDENCIA', 'SAAS')
# institucion(presidencia, 'GUARDIA PRESIDENCIAL', 'GP')
# institucion(mingob, 'DIRECCION DE SERVICIOS ADMINISTRATIVOS Y FINANCIEROS', 'DSAF')
# institucion(mingob, 'DIRECCION GENERAL DE INTELIGENCIA CIVIL', 'DGIC')
# institucion(mingob, 'DIRECCION GENERAL DE LA POLICIA NACIONAL CIVIL', 'DGPN')
# institucion(mingob, 'SECRETARIA DE ANALISIS E INFORMACION ANTINARCOTICA', 'SAIA')
# institucion(mingob, 'SUBDIRECCION GENERAL DE ESTUDIOS', 'SGE')
# institucion(mingob, 'SUBDIRECCION GENERAL DE SALUD POLICIAL', 'SGSP')
# institucion(mingob, 'SUBDIRECCION GENERAL DE INVESTIGACION CRIMINAL', 'SGIC')
# institucion(mingob, 'SUBDIRECCION GENERAL DE PREVENCION DEL DELITO', 'SGPD')
# institucion(mingob, 'DEPARTAMENTO DE TRANSITO', 'DT')
# institucion(mingob, 'DIRECCION GENERAL DEL SISTEMA PENITENCIARIO', 'DGSP')
# institucion(mingob, 'DIRECCION GENERAL DE MIGRACION', 'DGM')
# institucion(mingob, 'DIRECCION GENERAL DEL DIARIO DE CENTRO AMERICA Y TIPOGRAFIA NACIONAL', 'DGDCA')
# institucion(mingob, 'UNIDAD PARA LA PREVENCION COMUNITARIA DE LA VIOLENCIA', 'UPCV')
# institucion(mingob, 'REGISTRO DE PERSONAS JURIDICAS', 'RPJ')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE GUATEMALA', 'GDGUA')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE EL PROGRESO', 'GDPRO')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE SACATEPEQUEZ', 'GDSAC')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE CHIMALTENANGO', 'GDCHIM')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE ESCUINTLA', 'GDESC')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE SANTA ROSA', 'GDSROS')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE SOLOLA', 'GDSOL')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE TOTONICAPAN', 'GDTOT')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE QUETZALTENANGO', 'GDQUE')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE SUCHITEPEQUEZ', 'GDSUCH')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE RETALHULEU', 'GDREU')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE SAN MARCOS', 'GDSMAR')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE HUEHUETENANGO', 'GDHUE')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE QUICHE', 'GDQUI')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE BAJA VERAPAZ', 'GDBVER')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE ALTA VERAPAZ', 'GDAVER')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE PETEN', 'GDPET')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE IZABAL', 'GDIZA')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE ZACAPA', 'GDZAC')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE CHIQUIMULA', 'GDCHIQ')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE JALAPA', 'GDJAL')
# institucion(mingob, 'GOBERNACION DEPARTAMENTAL DE JUTIAPA', 'GDJUT')
# institucion(minfin, 'DIRECCION FINANCIERA', 'DF')
# institucion(minfin, 'DIRECCION DE RECURSOS HUMANOS', 'DRH')
# institucion(minfin, 'DIRECCION DE TECNOLOGIAS DE LA INFROMACION', 'DTI')
# institucion(minfin, 'AUDITORIA INTERNA', 'AI')
# institucion(minfin, 'DIRECCION DE SERVICIOS ADMINISTRATIVOS', 'DSA')
# institucion(minfin, 'ASESORIA JURIDICA', 'AJ')
# institucion(minfin, 'DIRECCION DE CATASTRO Y AVALUO DE BIENES INMUEBLES', 'DICABI')
# institucion(minfin, 'DIRECCION DE BIENES DEL ESTADO', 'DBIE')
# institucion(minfin, 'DIRECCION TECNICA DEL PRESUPUESTO', 'DTP')
# institucion(minfin, 'DIRECCION DE CONTABILIDAD DEL ESTADO', 'DCE')
# institucion(minfin, 'TESORERIA NACIONAL', 'TN')
# institucion(minfin, 'DIRECCION DE CREDITO PUBLICO', 'DCP')
# institucion(minfin, 'DIRECCION NORMATIVA DE CONTRATACIONES Y ADQUISICIONES DEL ESTADO', 'DNCAE')
# institucion(minfin, 'PROYECTO SIAF', 'SAG')
# institucion(minfin, 'TALLER NACIONAL DE GRABADOS EN ACERO', 'TNGA')
# institucion(mineduc, 'DIRECCION DE SERVICIOS ADMINISTRATIVOS', 'DISA')
# institucion(mineduc, 'DIRECCION DE INFORMATICA', 'DICABI')
# institucion(mineduc, 'DIRECCION DE RECURSOS HUMANOS', 'DIRH')
# institucion(mineduc, 'DICADE', 'DICADE')
# institucion(mineduc, 'DIRECCION DE PLANIFICACION EDUCATIVA', 'DIGEPE')
# institucion(mineduc, 'DIREC. GENERAL DE PROYECTOS DE APOYO', 'DIGEPA')
# institucion(mineduc, 'DIRECCION GENERAL DE EDUCACION BILINGUE INTERCULTURAL', 'DIGEBI')
# institucion(mineduc, 'DIRECCION GENERAL DE EDUCACION FISICA', 'DIGEFI')
# institucion(mineduc, 'DIRECCION GENERAL DE EDUCACION EXTRAESCOLAR', 'DIGEE')
# institucion(mineduc, 'DIRECCION DE COOPERACION NACIONAL E INTERNACIONAL', 'DIGECONI')
# institucion(mineduc, 'DIRECCION DE AUDITORIA INTERNA', 'DAI')
# institucion(mineduc, 'DIRECCION DE ASESORIA JURIDICA', 'DAJ')
# institucion(mineduc, 'DIRECCION DE COMUNICACION SOCIAL', 'DCS')
# institucion(mineduc, 'DIRECCION DE ADQUISICIONES Y CONTRATACIONES', 'DAC')
# institucion(mineduc, 'DIRECCION GENERAL DE COBERTURA E INFRAESTRUCTURA EDUCATIVA', 'DIGECIE')
# institucion(mineduc, 'DIRECCION GENERAL DE EVALUACION E INVESTIGACION EDUCATIVA', 'DIGEIE')
# institucion(mineduc, 'DIRECCIÓN GENERAL DE ACREDITACIÓ“N Y CERTIFICACIÓN', 'DIGAI')
# institucion(mineduc, 'DIRECCIÓN DE DESARROLLO Y FORTALECIMIENTO INSTITUCIONAL', 'DIDEFI')
# institucion(mineduc, 'DIRECCIÓN GENERAL DE PARTICIPACION COMUNITARIA Y SERVICIOS DE APOYO', 'DIGEPACSA')
# institucion(mineduc, 'DIRECCIÓN GENERAL DE GESTIÓN DE CALIDAD EDUCATIVA', 'DIGE')
# institucion(mineduc, 'DIRECCION GENERAL DE EDUCACION ESPECIAL', 'DIGEE')
# institucion(mineduc, 'DIRECCION GENERAL DE CURRICULO', 'DIGEC')
# institucion(mineduc, 'DIRECCION GENERAL DE FORTALECIMIENTO A LA COMUNIDAD EDUCATIVA', 'DIGEFOCE')
# institucion(mineduc, 'DIRECCION GENERAL DE MONITOREO Y VERIFICACION DE LA CALIDAD', 'DGME')
# institucion(mineduc, 'DIRECCION GENERAL DE COORDINACION DE DIRECCIONES DEPARTAMENTALES DE EDUCACION', 'DIGECODE')
# institucion(mineduc, 'DIRECCION DE DESARROLLO MAGISTERIAL', 'DDM')
# institucion(mineduc, 'DIRECCION EJECUTORA DEL PROGRAMA MI FAMILIA PROGRESA', 'DEPMP')
# institucion(mineduc, 'DIRECCION DE ADMINISTRACION FINANCIERA', 'DIAF')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE GUATEMALA', 'DDGUA')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE EL PROGRESO', 'DDPRO')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE SACATEPEQUEZ', 'DDSAC')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL EDUCACION DE CHIMALTENANGO', 'DDCHIM')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE ESCUINTLA', 'DDESC')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE SANTA ROSA', 'DDSROS')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE SOLOLA', 'DDSOL')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE TOTONICAPAN', 'DDTOTO')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE QUETZALTENANGO', 'DDQUET')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE SUCHITEPEQUEZ', 'DDSUCH')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE RETALHULEU', 'DDREU')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE SAN MARCOS', 'DDSMARC')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE HUEHUETENANGO', 'DDHUE')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE EL QUICHE', 'DDQUI')
# institucion(mineduc, 'DIRECCCION DEPARTAMENTAL DE EDUCACION DE BAJA VERAPAZ', 'DDBVER')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE ALTA VERAPAZ', 'DDAVER')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE PETEN', 'DDPET')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE IZABAL', 'DDIZA')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE ZACAPA', 'DDZAC')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE CHIQUIMULA', 'DDCHIQ')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE JALAPA', 'DDJAL')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION DE JUTIAPA', 'DDJUT')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION GUATEMALA NORTE', 'DDGUAN')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION GUATEMALA SUR', 'DDGUAS')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION GUATEMALA ORIENTE', 'DDGUAOR')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION GUATEMALA OCCIDENTE', 'DDGUAOC')
# institucion(mineduc, 'DIRECCION DEPARTAMENTAL DE EDUCACION PETEN CENTRAL', 'DDPETCEN')
# institucion(minpas, 'DEPARTAMENTO ADMINISTRATIVO', 'DA')
# institucion(minpas, 'AREA DE SALUD GUATEMALA NOR ORIENTE', 'ASGNOROR')
# institucion(minpas, 'AREA DE SALUD GUATEMALA NOR OCCIDENTE', 'ASGNOROC')
# institucion(minpas, 'AREA DE SALUD GUATEMALA SUR', 'ASGSUR')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE EL PROGRESO', 'JASPRO')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE SACATEPEQUEZ', 'JASSAC')
# institucion(minpas, 'JEFE DE AREA DE SALUD DE CHIMALTENANGO', 'JASCHIM')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE ESCUINTLA', 'JASESC')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE SANTA ROSA', 'JASSROS')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE SOLOLA', 'JASSOL')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE TOTONICAPAN', 'JASTOTO')
# institucion(minpas, 'JEFATURA DE  AREA DE SALUD DE QUETZALTENANGO', 'JASQUET')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE SUCHITEPEQUEZ', 'JASSUCHI')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE RETALHULEU', 'JASREU')
# institucion(minpas, ' JEFATURA DE AREA DE SALUD DE SAN MARCOS', 'JASSMARC')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE HUHUETENANGO', 'JASHUE')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DEL QUICHE', 'JASQUI')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE IXCAN', 'JASIXCAN')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE BAJA VERAPAZ', 'JASBVER')
# institucion(minpas, ' JEFATURA DE AREA DE SALUD DE ALTA VERAPAZ', 'JASAVER')
# institucion(minpas, ' JEFATURA DE AREA DE SALUD DE PETEN NORTE', 'JASPETNO')
# institucion(minpas, ' JEFE DE AREA DE SALUD DE IZABAL', 'JASIZA')
# institucion(minpas, 'JEFATURA DE AREA DE SALUD DE ZACAPA', 'JASZAC')
# institucion(minpas, 'JEFATURA DE AREA DE CHIQUIMULA', 'JASCHIQ')
# institucion(minpas, ' JEFATURA DE AREA DE SALUD DE JALAPA', 'JASJAL')
# institucion(minpas, ' JEFATURA DE AREA DE SALUD DE JUTIAPA', 'JASJUT')
# institucion(minpas, 'HOSPITAL GENERAL SAN JUAN DE DIOS', 'HGSJD')
# institucion(minpas, 'HOSPITAL DE SALUD MENTAL', 'HSM')
# institucion(minpas, 'HOSPITAL DE ORTOPEDIA Y REHABILITACION', 'HOR')
# institucion(minpas, 'HOSPITAL ROOSEVELT', 'HROOS')
# institucion(minpas, 'HOSPITAL DE INFECTOLOGMA Y REHABILITACION', 'HIR')
# institucion(minpas, 'HOSPITAL DE SAN VICENTE', 'HSVIC')
# institucion(minpas, 'HOSPITAL DE AMATITLAN', 'HAMAT')
# institucion(minpas, ' HOSPITAL DE EL PROGRESO', 'HPROG')
# institucion(minpas, 'HOSPITAL PEDRO DE BETHANCOURT', 'HPBET')
# institucion(minpas, 'HOGAR DE ANCIANOS FRAY R. DE LA CRUZ', 'HAFRDLC')
# institucion(minpas, 'HOSPITAL  DE CHIMALTENANGO', 'HCHIM')
# institucion(minpas, 'HOSPITAL DE ESCUINTLA', 'HESC')
# institucion(minpas, 'HOSPITAL DE  TIQUISATE', 'HTIQUI')
# institucion(minpas, 'HOSPITAL DE CUILAPA', 'HCUIL')
# institucion(minpas, 'HOSPITAL DE SOLOLA', 'HSOL')
# institucion(minpas, 'HOSPITAL DE TOTONICAPAN', 'HTOTO')
# institucion(minpas, 'HOSPITAL GENERAL DE OCCIDENTE', 'HGOCC')
# institucion(minpas, 'HOSPITAL RODOLFO ROBLES', 'HRR')
# institucion(minpas, 'HOSPITAL DE COATEPEQUE', 'HCOATE')
# institucion(minpas, 'HOSPITAL DE MAZATENANGO', 'HMAZAT')
# institucion(minpas, 'HOSPITAL DE RETALHULEU', 'HREU')
# institucion(minpas, 'HOSPITAL DE  SAN MARCOS', 'HSMARC')
# institucion(minpas, 'HOSPITAL DE MALACATAN', 'HMALAC')
# institucion(minpas, 'HOSPITAL DE HUEHUETENANGO', 'HHUE')
# institucion(minpas, 'HOSPITAL DE SAN PEDRO NECTA', 'HSPN')
# institucion(minpas, 'HOSPITAL DE QUICHE', 'HQUICHE')
# institucion(minpas, 'HOSPITAL DE SALAMA', 'HSALAMA')
# institucion(minpas, 'HOSPITAL DE COBAN', 'HCOBAN')
# institucion(minpas, 'HOSPITAL DE SAN BENITO', 'HSBENIT')
# institucion(minpas, 'HOSPITAL DE  MELCHOR DE MENCOS', 'HMMENC')
# institucion(minpas, 'HOSPITAL DE SAYAXCHI', 'HSAYAX')
# institucion(minpas, 'CENTRO DE SALUD  DE POPTUN', 'CSPOPT')
# institucion(minpas, 'HOSPITAL DE PUERTO BARRIOS', 'HPTOBARR')
# institucion(minpas, 'HOSPITAL INFANTIL DE PUERTO BARRIOS', 'HINFPTOB')
# institucion(minpas, 'HOSPITAL DE  ZACAPA', 'HZACAP')
# institucion(minpas, 'HOSPITAL DE CHIQUIMULA', 'HCHIQ')
# institucion(minpas, 'HOSPITAL DE JALAPA', 'HJAL')
# institucion(minpas, 'HOSPITAL DE JUTIAPA', 'HJUT')
# institucion(minpas, 'AREA DE SALUD DE PETEN SUROCCIDENTE', 'ASPETSOCC')
# institucion(minpas, 'AREA DE SALUD DE PETEN SURORIENTE', 'ASPETSOR')
# institucion(minpas, 'HOSPITAL DE JOYABAJ', 'HJOYAB')
# institucion(minpas, 'HOSPITAL DE NEBAJ', 'HNEBAJ')
# institucion(minpas, 'HOSPITAL DE USPANTAN', 'HUSPANT')
# institucion(minpas, 'HOSPITAL FRAY BARTOLOME DE LAS CASAS', 'HFRAYBAR')
# institucion(minpas, 'HOSPITAL DE LA TINTA', 'HLATINTA')
# institucion(minpas, 'ESCUELAS FORMADORAS EN LA CAPITAL', 'EFCAPITAL')
# institucion(minpas, 'ESCUELAS FORMADORAS EN COBAN A.V.', 'EFCOBAN')
# institucion(minpas, 'ESCUELAS FORMADORAS EN QUETZALTENANGO', 'EFQUET')
# institucion(minpas, 'ESCUELAS FORMADORAS EN MAZATENANGO', 'EFMAZATE')
# institucion(minpas, 'ESCUELAS FORMADORAS EN JUTIAPA', 'EFJUTIAPA')
# institucion(minpas, 'INSTITUTO DE ADIESTRAMIENTO DE PERSONAL INDAPS', 'INDAPS')
# institucion(minpas, 'AREA DE SALUD GUATEMALA CENTRAL', 'ASGUACEN')
# institucion(minpas, 'PROGRAMA DE ACCESIBILIDAD DE MEDICAMENTOS', 'PAMED')
# institucion(minpas, 'LABORATORIO NACIONAL DE SALUD', 'LABNACSA')
# institucion(minpas, 'CEMENTERIO NACIONAL', 'CEMNAC')
# institucion(minpas, 'AREA DE SALUD IXIL', 'ASIXIL')
# institucion(micivi, 'DIRECCION SUPERIOR', 'DS')
# institucion(micivi, 'DIRECCION GENERAL DE CAMINOS', 'DGC')
# institucion(micivi, 'UNIDAD EJECUTORA DE CONSERVACION VIAL ', 'COVIAL')
# institucion(micivi, 'DIRECCION GENERAL DE TRANSPORTES', 'DGT')
# institucion(micivi, 'DIRECCION GENERAL DE AERONAUTICA CIVIL', 'DGAC')
# institucion(micivi, 'UNIDAD DE CONSTRUCCION DE EDIFICIOS DEL ESTADO ', 'UCEE')
# institucion(micivi, 'DIRECCION GENERAL DE RADIODIFUSION Y TELEVISION NACIONAL', 'DGR')
# institucion(micivi, 'UNIDAD DE CONTROL Y SUPERVISION DE CABLE ', 'UNCOSU')
# institucion(micivi, 'INSTITUTO NACIONAL DE SISMOLOGIA, VULCANOLOGIA, METEOROLOGIA E HIDROLOGIA ', 'INSIVUMEH')
# institucion(micivi, 'DIRECCION GENERAL DE CORREOS Y TELEGRAFOS', 'DGCT')
# institucion(micivi, 'SUPERINTENDENCIA DE TELECOMUNICACIONES ', 'SIT')
# institucion(micivi, 'FONDO PARA EL DESARROLLO DE LA TELEFONIA ', 'FONDETEL')
# institucion(micivi, 'FONDO GUATEMALTECO PARA LA VIVIENDA ', 'FOGUAVI')
# institucion(micivi, 'UNIDAD PARA EL DESARROLLO DE VIVIENDA POPULAR ', 'UDEVIPO')
# institucion(micivi, 'DIRECCION GENERAL DE PROTECCION Y SEGURIDAD VIAL ', 'PROVIAL')
# institucion(micude, 'DIRECCION SUPERIOR', 'DS')
# institucion(micude, 'DIRECCION GENERAL DE LAS ARTES', 'DGA')
# institucion(micude, 'DIRECCION GENERAL DEL PATRIMONIO CULTURAL Y NATURAL', 'DGPCYN')
# institucion(micude, 'DIRECCION GENERAL DEL DEPORTE Y LA RECREACION', 'DGDYR')
# institucion(micude, 'DIRECCION GENERAL DE DESARROLLO CULTURAL Y FORTALECIMIENTO DE LAS CULTURAS', 'DGDCYFC')
# institucion(sodeej, 'SECRETARIA GENERAL', 'SG')
# institucion(sodeej, 'COMISION PRESIDENCIAL COORDINADORA DE DERECHOS HUMANOS', 'COPREDEH')
# institucion(sodeej, 'SECRETARIA PRIVADA DE LA PRESIDENCIA', 'SP')
# institucion(sodeej, 'SECRETARIA DE COORDINACION  EJECUTIVA  DE LA PRESIDENCIA', 'SCEP')
# institucion(sodeej, 'FONDO NACIONAL PARA LA PAZ', 'FONAPAZ')
# institucion(sodeej, 'FONDO DE DESARROLLO INDIGENA GUATEMALTECO', 'FODIGUA')
# institucion(sodeej, 'SECRETARIA DE COMUNICACION SOCIAL DE LA PRESIDENCIA DE LA R.', 'SCSPR')
# institucion(sodeej, 'SECRETARIA DE BIENESTAR SOCIAL DE LA PRESIDENCIA DE LA REP.', 'SBS')
# institucion(sodeej, 'SECRETARIA DE LA PAZ', 'SEPAZ')
# institucion(sodeej, 'OFICINA NACIONAL DE SERVICIO CIVIL', 'ONSEC')
# institucion(sodeej, 'CONSEJO NACIONAL DE AREAS PROTEGIDAS', 'CONAP')
# institucion(sodeej, 'AUTORIDAD PARA EL RESCATE DEL LAGO DE AMATITLAN', 'ARLA')
# institucion(sodeej, 'SECRETARIA DE PLANIFICACION Y PROGRAMACION DE LA PRESIDENCIA', 'SEGEPLAN')
# institucion(sodeej, 'CONSEJO NACIONAL DE LA JUVENTUD', 'CONJUVE')
# institucion(sodeej, 'SECRETARIA EJECUTIVA COMISION CONTRA ADIC TRAFIC ILIC DROGAS', 'SECATID')
# institucion(sodeej, 'SECRETARIA  NACIONAL DE CIENCIA Y TECNOLOGIA', 'SENACIT')
# institucion(sodeej, 'SECRETARIA DE OBRAS SOCIALES DE LA ESPOSA DEL PRESIDENTE', 'SOSEP')
# institucion(sodeej, 'SECRETARIA DE ANALISIS ESTRATEGICO.', 'SAE')
# institucion(sodeej, 'SECRETARIA PRESIDENCIAL DE LA MUJER', 'SEPREM')
# institucion(sodeej, 'SECRETARIA DE ASUNTOS AGRARIOS DE LA PRESIDENCIA DE LA REP', 'SAA')
# institucion(sodeej, 'COMISION PRESIDENCIAL CONTRA LA DISCRIMINACION Y EL RACISMO CONTRA LOS PUEBLOS INDIGENAS', 'CODISRA')
# institucion(sodeej, 'SECRETARIA DE SEGURIDAD ALIMENTARIA Y NUTRICIONAL DE LA PRESIDENCIA DE LA REPUBLICA', 'SESAM')
# institucion(sodeej, 'AUTORIDAD PARA EL MANEJO SUSTENTABLE DE LA CUENCA DEL LAGO DE ATITLAN Y SU ENTORNO', 'AMSCLAE')
# institucion(sodeej, 'DEFENSORIA DE LA MUJER INDIGENA', 'DEMI')
# institucion(sodeej, 'FONDO NACIONAL DE DESARROLLO', 'FONADES')


# institucion(autonomas,'SUPERINTENDENCIA DE ADMINISTRACION TRIBUTATIA','SAT')
# institucion(autonomas,'PROCURADORIA DE LOS DERECHOS HUMANOS','PDH')


# #activacion de 
