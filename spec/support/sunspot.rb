require 'sunspot/rails/spec_helper'
require 'net/http'

try_server = proc do |uri|
  begin
    Net::HTTP.get_response uri
  rescue Errno::ECONNREFUSED
  end
end

start_server = proc do |timeout|

  server = Sunspot::Rails::Server.new
  uri = URI.parse("http://0.0.0.0:#{server.port}/solr/")

  try_server[uri] or begin

    server.start
    at_exit { server.stop }

    timeout.times.any? do
      sleep 1
      try_server[uri]
    end
  end
end

original_session = nil            # always nil between specs
sunspot_server = nil              # one server shared by all specs

if defined? Spork
  Spork.prefork do
    sunspot_server = start_server[60] if Spork.using_spork?
  end
end

RSpec.configure do |config|

  config.before(:each) do
    if example.metadata[:solr]    # it "...", solr: true do ... to have real SOLR
      sunspot_server ||= start_server[60] || raise("SOLR connection timeout")

    else
      original_session = Sunspot.session
      Sunspot.session = Sunspot::Rails::StubSessionProxy.new(original_session)
    end
  end

  config.after(:each) do
    if example.metadata[:solr]
      Sunspot.remove_all!

    else
      Sunspot.session = original_session
    end
    original_session = nil
  end
end
