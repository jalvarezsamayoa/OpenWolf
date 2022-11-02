# -*- coding: utf-8 -*-
source 'http://rubygems.org'

gem 'rails', '3.0.9'

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
gem 'formtastic', :git => 'git://github.com/justinfrench/formtastic.git' # genera formularios semanticos
gem 'validation_reflection' # obtiene datos de campos a validar, para uso con formtastic

gem 'sunspot_solr'
gem 'sunspot_rails' #indexamiento y busqueda (fulltext) via solr

gem 'paperclip' # modulo para hacer upload a archivos
gem 'tiny_mce' # editor html
gem 'pdfkit', "0.8.7.2" # generacion de pdf's
gem 'will_paginate' # pagineo de resultados
gem 'jquery-rails', '>= 0.2.6' #jquery para rails, remplaza prototype y scriptaculous

gem 'galetahub-simple_captcha', :require => 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'
#gem "recaptcha", :require => "recaptcha/rails" #plugin para añadir recaptcha a formularios

# HERRAMIENTAS
gem 'admin_data', :git => 'git://github.com/bigbinary/admin_data.git' # modulo para administracion de base de datos
gem 'whenever' # manejo de cronjobs
gem 'activerecord-import', '>= 0.2.0' # herramienta para importacion de data
gem 'serenity-odt' #generacion de templates ODT
gem 'fastercsv' #manejo de archivos CSV
gem 'vestal_versions', :git => 'git://github.com/adamcooper/vestal_versions' #manejor de versiones de modelos
gem 'progress_bar' # muestra barra progreso en consola

gem 'daemons'
gem 'delayed_job_active_record'
gem 'delayed_job' # envia procesos a background - en uso para enviar correos

gem 'dalli' # interfaz con servicio de almacenamiento de cache de objetos Memcached - memcached.org
gem 'backup' #libreria para generar backups de aplicacion

# MONITOREO
gem 'newrelic_rpm' # monitoreo de performance http://newrelic.com
gem 'airbrake' #notificacion de errores via http://hoptoadapp.com/

# Generacion de Imagenes
gem 'rmagick'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'highline'
  gem 'hirb'
  gem 'pry'
  gem 'webrat'
  gem 'silent-postgres' #elimina la salida de el log de postgresql
  gem 'faker' # herramienta para generacion de datos de prueba
  gem 'ruby-prof'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'foreman'
  gem 'rvm-capistrano'
end

# TESTING

group  :test do
  gem 'simplecov', '>=0.3.8', :require => false


  gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"


  gem 'remarkable', '>=4.0.0.alpha2'
  gem 'remarkable_activemodel', '>=4.0.0.alpha2'
  gem 'remarkable_activerecord', '>=4.0.0.alpha2'

  gem "capybara"
  gem "factory_girl_rails" # https://github.com/thoughtbot/factory_girl_rails
  gem "launchy"

  gem 'rb-inotify'
  gem 'libnotify'
  gem 'test_notifier'

  gem 'ZenTest', "~>4.4.2"

  gem "spork", "0.9.0.rc9"

  gem 'email_spec'

  gem "hirb"
end
