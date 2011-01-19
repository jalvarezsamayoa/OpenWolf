# language: es
Característica: Usuario superadmin ingresa a portal estatal
Para poder adminstrar el sistema
Superadmin necesitara autenticarse para ingresar al sistema

Escenario: Ingresar a portal estatal
Dado que existe el usuario "eladmin" con perfil "superadmin"
Y que visito la pagina de inicio
Y que hago click en "Portal Estatal"
Entonces debo de estar en la pagina de autenticacion

Dado que ingreso "superadmin" en "usuario_login"
Y que ingreso "123456" en "usuario_password"
Y que presiono "login_button"
Entonces debo de estar en el panel de contro
l

