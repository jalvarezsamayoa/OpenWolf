# Creacion de usuarios y roles de seguridad

def asignar_nivel(username, role)
  u = Usuario.find_by_username(username)
  u.has_role!(role)  
end

PRES = 8
VICE = 16
PDH = 353
MARN = 319

# usuarios = Usuario.create( [{:username => 'superadmin',
#                               :email => 'admin@openwolf.org',
#                               :nombre => 'Administrador',
#                               :cargo => 'Administrador OpenWolf',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => 1},
#                             {:username => 'localadmin',
#                               :email => 'admininst@openwolf.org',
#                               :nombre => 'Administrador Institucion',
#                               :cargo => 'Administrador Institucion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => VICE},
#                             {:username => 'superudip',
#                               :email => 'superudip@openwolf.org',
#                               :nombre => 'Encargado UDIP',
#                               :cargo => 'Encargado Unidad Informacion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => VICE},
#                             {:username => 'userudip',
#                               :email => 'userudip@openwolf.org',
#                               :nombre => 'Operador UDIP',
#                               :cargo => 'Operador Unidad Informacion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => VICE},
#                             {:username => 'enlace',
#                               :email => 'usuario@openwolf.org',
#                               :nombre => 'Enlace Institucion',
#                               :cargo => 'Usuario Final Institucion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => VICE},
#                             {:username => 'test',
#                               :email => 'test@openwolf.org',
#                               :nombre => 'Operador UDIP Prueba',
#                               :cargo => 'Operador Unidad Informacion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => PDH},
#                             {:username => 'superpres',
#                               :email => 'superpres@openwolf.org',
#                               :nombre => 'Super Pres.',
#                               :cargo => 'Encargado Unidad Informacion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                               :institucion_id => PRES}
#                            ]                          
#                            )

u = Usuario.find_by_username('superadmin')
u.has_role!(:superadmin)

u = Usuario.find_by_username('localadmin')
u.has_role!(:localadmin)

u = Usuario.find_by_username('superudip')
u.has_role!(:superudip)

u = Usuario.find_by_username('userudip')
u.has_role!(:userudip)

u = Usuario.find_by_username('enlace')
u.has_role!(:enlace)

u = Usuario.find_by_username('test')
u.has_role!(:superudip)

#crear usuarios ministerio de medio ambiente
# usuarios = Usuario.create([{:username => 'hlopez',
#                              :email => 'hlopez@marn.gob.gt',
#                              :nombre => 'Lic. Hernan Leopoldo López Ordóñez',
#                              :cargo => 'Unidad de Auditoria Interna',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'jpsuarez',
#                              :email => 'jpsuarez@marn.gob.gt',
#                              :nombre => 'Juan Pablo Suárez',
#                              :cargo => 'Unidad de Protocolo',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'vovalle',
#                              :email => 'vovalle@marn.gob.gt',
#                              :nombre => 'Licda. Vilma Judith Ovalle González',
#                              :cargo => 'Direccion General de Formación Organizacion y Participación Social',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'clegal',
#                              :email => 'clegal@marn.gob.gt',
#                              :nombre => 'Lic. Carlos Orozco Trejo',
#                              :cargo => 'Dirección General de cumplimiento legal',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'lmpaiz',
#                              :email => 'lmpaiz@marn.gob.gt',
#                              :nombre => 'Lic. Leslie Mynor Paiz Lobos',
#                              :cargo => 'Secretaría General',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'mcifuentes',
#                              :email => 'mcifuentes@marn.gob.gt',
#                              :nombre => 'Ing. Martín Alejandro Cifuentes Domínguez',
#                              :cargo => 'Dirección General de Políticas y Estrategias Abmientales',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'benavente.claudia',
#                              :email => 'benavente.claudia@marn.gob.gt',
#                              :nombre => 'Licda. Claudia Benavente Ramirez',
#                              :cargo => 'Unidad de Relaciones Públicas',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'lrmolina',
#                              :email => 'lrmolina@marn.gob.gt',
#                              :nombre => 'Lumar René Moina Fuentes',
#                              :cargo => 'Dirección Administración y Finanzas',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'ondl',
#                              :email => 'ondl@marn.gob.gt',
#                              :nombre => 'María Elena Tayun',
#                              :cargo => 'Oficina Nacional de Desarrollo Limpio',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'w2ramirez',
#                              :email => 'w2ramirez@gmail.com',
#                              :nombre => 'Werner Ramirez',
#                              :cargo => 'Programa Nacional de Cambio Climatico',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'jicoti',
#                              :email => 'jicoti@marn.gob.gt',
#                              :nombre => 'José Llich Coty',
#                              :cargo => 'Programa nacional de Cambio Climático',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'jaramas',
#                              :email => 'jaramas@marn.gob.gt',
#                              :nombre => 'Lic. José Adolfo Ramas',
#                              :cargo => 'Dirección General de Administración y Finanzas',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'jcalvarado',
#                              :email => 'jcalvarado@marn.gob.gt',
#                              :nombre => 'José Carlos Alvarado',
#                              :cargo => 'Dirección General de Informática',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'cmartinez',
#                              :email => 'cmartinez@marn.gob.gt',
#                              :nombre => 'Carlos Martínez',
#                              :cargo => 'Area de Inventarios',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'bdeguay',
#                              :email => 'bdeguay@marn.gob.gt',
#                              :nombre => 'Blanca de Guay',
#                              :cargo => 'Tesorería',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                             {:username => 'compras',
#                              :email => 'compras@marn.gob.gt',
#                              :nombre => 'Francisco Marroquín',
#                              :cargo => 'Encargado de Compras',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'emejia',
#                              :email => 'emejia@marn.gob.gt',
#                              :nombre => 'Eber Mejia',
#                              :cargo => 'Caja',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'cgonzalez',
#                              :email => 'cgonzalez@marn.gob.gt',
#                              :nombre => 'Licda. Claudeth González',
#                              :cargo => 'Programa RBM',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'jdedios',
#                              :email => 'jdedios@marn.gob.gt',
#                              :nombre => 'Dr. Juan de Dios Calle',
#                              :cargo => 'Unidad de Control de Productos Químicos',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'velhair',
#                              :email => 'velhair@marn.gob.gt',
#                              :nombre => 'Victor García',
#                              :cargo => 'Gestión Ambiental',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'chgonzalez',
#                              :email => 'chgonzalez@marn.gob.gt',
#                              :nombre => 'Lic. Carlos Gonzalez Torres',
#                              :cargo => 'Unidad de Recursos Hídricos',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'cmdonis',
#                              :email => 'cmdonis@marn.gob.gt',
#                              :nombre => 'Cindy Maritza Donis Carrillo',
#                              :cargo => 'Asesoría Jurídica',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'mlopez',
#                              :email => 'mlopez@marn.gob.gt',
#                              :nombre => 'Licda. Merminia López Aquino',
#                              :cargo => 'Recursos Humanos',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN },
#                            {:username => 'adlperez',
#                              :email => 'adlperez@marn.gob.gt',
#                              :nombre => 'adlperez',
#                              :cargo => 'Coordinación Nacional',
#                              :password => '123456',
#                              :password_confirmation => '123456',
#                              :puesto_id => 1,
#                              :institucion_id => MARN }                                                      ])

asignar_nivel('hlopez',:superudip)
asignar_nivel('jpsuarez',:enlace)
asignar_nivel('vovalle',:enlace)
asignar_nivel('clegal',:enlace)
asignar_nivel('lmpaiz',:enlace)
asignar_nivel('mcifuentes',:enlace)
asignar_nivel('benavente.claudia',:enlace)
asignar_nivel('lrmolina',:enlace)
asignar_nivel('ondl',:enlace)
asignar_nivel('w2ramirez',:enlace)
asignar_nivel('jicoti',:enlace)
asignar_nivel('jcalvarado',:localadmin)
asignar_nivel('cmartinez',:enlace)
asignar_nivel('bdeguay',:enlace)
asignar_nivel('compras',:enlace)
asignar_nivel('emejia',:enlace)
asignar_nivel('cgonzalez',:enlace)
asignar_nivel('jdedios',:enlace)
asignar_nivel('velhair',:enlace)
asignar_nivel('chgonzalez',:enlace)
asignar_nivel('cmdonis',:enlace)
asignar_nivel('mlopez',:enlace)
asignar_nivel('adlperez',:enlace)

#crear usuarios de sat
# usuarios = Usuario.create([{ :username => 'enlacegrc',
#                               :email => 'enlacegrc@openwolf.org',
#                               :nombre => 'Enlace Region Central',
#                               :cargo => 'Enlace Unidad Informacion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                              :institucion_id => SAT},
#                            { :username => 'enlacegi',
#                               :email => 'enlacegi@openwolf.org',
#                               :nombre => 'Enlace Gerencia Informatica',
#                               :cargo => 'Enlace Unidad Informacion',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                              :institucion_id => SAT},
#                           { :username => 'supersat',
#                               :email => 'supersat@openwolf.org',
#                               :nombre => 'Lic. Angel Menendez',
#                               :cargo => 'Gerente de Orientacion Legal y Derechos del Contribuyente',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                              :institucion_id => SAT},
#                            { :username => 'usersat',
#                               :email => 'usersat@openwolf.org',
#                               :nombre => 'Usuario Unidad Informacion',
#                               :cargo => 'Usuario UDIP',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                              :institucion_id => SAT},
#                            { :username => 'localsat',
#                               :email => 'localsat@openwolf.org',
#                               :nombre => 'Encargado Informatica',
#                               :cargo => 'Administrador Local OpenWolf',
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                              :institucion_id => SAT},
#                           ])


#asignacion permisos usuario presidencia
# u = Usuario.find_by_username('superpres')
# u.has_role!(:superudip)

# #asignacion permisos usuarios sat
# u = Usuario.find_by_username('localsat')
# u.has_role!(:localadmin)
# u = Usuario.find_by_username('supersat')
# u.has_role!(:superudip)
# u = Usuario.find_by_username('usersat')
# u.has_role!(:userudip)
# u = Usuario.find_by_username('enlacegrc')
# u.has_role!(:enlace)
# u = Usuario.find_by_username('enlacegi')
# u.has_role!(:enlace)

#crear usuarios ciudadanos
# for i in Institucion.instituciones do

#   {:localadmin => 'local_',
#     :superudip => 'super_',
#     :userudip => 'user_',
#     :enlace => 'enlace_',
#     :ciudadano => 'ciudadano_'}.each { |key, value|
    
#     #crear usuario ciudadano
#     username = value + i.abreviatura.downcase

#     if Usuario.find_by_username(username)
#       username += '_' + i.codigo.tr('-','_')
#       nombre = value.capitalize.chomp + ' ' + i.abreviatura + ' ' + i.codigo.tr('-','_')
#     else
#       nombre = value.capitalize.chomp + ' ' + i.abreviatura
#     end
    
#     email = username.tr('-','') +  "@openwolf.org"
            
#     cargo = 'Usuario ' + value.capitalize.chomp

#     usuario = Usuario.find_by_email(email)
#     # 
#     # unless usuario.valid?
#     #    puts usuario.inspect
#     #  end
#     #usuario.save!
#     if usuario.nil?
#       usuario = Usuario.new(:username => username,
#                               :email => email,
#                               :nombre => nombre,
#                               :cargo => cargo,
#                               :password => '123456',
#                               :password_confirmation => '123456',
#                               :puesto_id => 1,
#                             :institucion_id => i.id)
#       usuario.save!

#     end
#     usuario.has_role!(key)
    
#   }
# end
