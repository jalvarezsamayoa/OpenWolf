source 'http://rubygems.org'

gem 'rake', '~> 0.8.7'

gem 'rails', '3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# BASE DE DATOS
gem 'pg' # adaptador de postgresql

# DEPLOYMENT
gem 'capistrano' # herramienta para hacer deployment de la aplicacion

# AUTENTICACION
gem 'devise' # libreria de autenticacion
gem 'acl9' # libreria de manejo de roles de usuario

# HELPERS
gem 'haml' # sistema para generacion de templates
gem 'nokogiri'
gem 'hpricot'
gem 'ruby_parser'
gem 'formtastic' # genera formularios semanticos
gem 'validation_reflection' # obtiene datos de campos a validar, para uso con formtastic
gem 'sunspot_rails' #indexamiento y busqueda (fulltext) via solr
gem 'paperclip' # modulo para hacer upload a archivos
gem 'tiny_mce' # editor html 
gem 'pdfkit', "0.4.6" # generacion de pdf's
gem 'will_paginate' # pagineo de resultados
gem 'jquery-rails', '>= 0.2.6' #jquery para rails, remplaza prototype y scriptaculous

# HERRAMIENTAS
gem 'admin_data', :git => "git://github.com/neerajdotname/admin_data.git" # modulo para administracion de base de datos
gem 'whenever' # manejo de cronjobs
gem 'activerecord-import', '>= 0.2.0' # herramienta para importacion de data
gem 'serenity-odt' #generacion de templates ODT
gem 'fastercsv' #manejo de archivos CSV
gem 'vestal_versions', :git => 'git://github.com/adamcooper/vestal_versions' #manejor de versiones de modelos
gem 'delayed_job' # envia procesos a background - en uso para enviar correos
gem 'dalli' # interfaz con servicio de almacenamiento de cache de objetos Memcached - memcached.org
gem 'backup' #libreria para generar backups de aplicacion

# MONITOREO
gem 'newrelic_rpm' # monitoreo de performance http://newrelic.com
gem 'hoptoad_notifier' #notificacion de errores via http://hoptoadapp.com/

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

# TESTING
group :development, :test do
   gem 'silent-postgres' #elimina la salida de el log de postgresql 
   gem 'faker' # herramienta para generacion de datos de prueba
   gem "rspec-rails", ">=2.0.1" # http://relishapp.com/rspec/rspec-rails
   gem 'remarkable', '>=4.0.0.alpha2'
   gem 'remarkable_activemodel', '>=4.0.0.alpha2'
   gem 'remarkable_activerecord', '>=4.0.0.alpha2'   
   gem "autotest"
   gem "capybara"
   gem "factory_girl_rails" # https://github.com/thoughtbot/factory_girl_rails
   gem "cucumber-rails"
   gem "hirb"
end
