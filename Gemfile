# -*- coding: utf-8 -*-
source 'http://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# BASE DE DATOS
gem 'pg' # adaptador de postgresql

# Servidor
gem 'thin'

# DEPLOYMENT
gem 'capistrano' # herramienta para hacer deployment de la aplicacion

# AUTENTICACION
gem 'devise' # libreria de autenticacion
gem 'acl9' # libreria de manejo de roles de usuario

# Active Record
gem 'awesome_nested_set'

# HELPERS
gem 'haml' # sistema para generacion de templates
gem 'nokogiri'
gem 'hpricot'
gem 'ruby_parser'

# VIEWS
gem 'simple_form'
gem 'tiny_mce' # editor html
gem 'pdfkit', "0.4.6" # generacion de pdf's
gem 'will_paginate' # pagineo de resultados
gem 'jquery-rails' #jquery para rails, remplaza prototype y scriptaculous
gem 'paperclip' # modulo para hacer upload a archivos
gem 'galetahub-simple_captcha', :require => 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'

# INDEXAMIENTO
gem 'pg_search'
gem 'sunspot_solr'
gem 'sunspot_rails' #indexamiento y busqueda (fulltext) via solr


# HERRAMIENTAS
gem 'admin_data', :git => 'git://github.com/bigbinary/admin_data.git' # modulo para administracion de base de datos
gem 'whenever' # manejo de cronjobs
gem 'activerecord-import', '~> 0.2.9' # herramienta para importacion de data
gem 'serenity-odt' #generacion de templates ODT
gem 'fastercsv' #manejo de archivos CSV
#gem 'vestal_versions', :git => 'git://github.com/adamcooper/vestal_versions' #manejor de versiones de modelos
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


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'twitter-bootstrap-rails',  :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end


# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'highline'
  gem 'pry'
  gem 'silent-postgres' #elimina la salida de el log de postgresql
  gem 'faker' # herramienta para generacion de datos de prueba
  gem 'ruby-prof'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'foreman'
  gem 'guard'
  gem 'guard-livereload'
  gem 'rb-inotify'
  gem 'libnotify'
  gem 'debugger'
end



# TESTING

group  :test do

  gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"


  gem "capybara"
  gem "factory_girl_rails" 
  gem "launchy"

  gem 'rb-inotify'
  gem 'libnotify'
  gem 'test_notifier'

  gem 'ZenTest'

  gem "spork"

  gem 'email_spec'
end
