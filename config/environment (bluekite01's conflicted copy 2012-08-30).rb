# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OpenwolfV3::Application.initialize!

Haml::Template.options[:format] = :html5
