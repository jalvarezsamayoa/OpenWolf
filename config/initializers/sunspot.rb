case Rails.env
when 'development'
  Sunspot.config.solr.url = 'http://locahost:8982/solr'
when 'test'
  Sunspot.config.solr.url = 'http://locahost:8983/solr'
when 'production'
  Sunspot.config.solr.url = 'http://locahost:8983/solr'
when 'staging'
  Sunspot.config.solr.url = 'http://locahost:8984/solr'
end
