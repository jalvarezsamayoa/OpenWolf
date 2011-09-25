case Rails.env
when 'development'
  Sunspot.config.solr.url = 'http://locahost:8982/solr'
  Sunspot.config.solr.port = 8982
when 'test'
  Sunspot.config.solr.url = 'http://locahost:8983/solr'
  Sunspot.config.solr.port = 8983
when 'production'
  Sunspot.config.solr.url = 'http://locahost:8983/solr'
  Sunspot.config.solr.port = 8983
when 'staging'
  Sunspot.config.solr.url = 'http://locahost:8984/solr'
  Sunspot.config.solr.port = 8984
end
