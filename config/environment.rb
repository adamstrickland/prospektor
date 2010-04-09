# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

require 'mockingbird/custom_validations'
require 'active_record_extensions'

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # config.gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"
  
  config.gem 'uuidtools', :version => '2.1.1'
  config.gem 'fastercsv', :version => '1.5.0'
  config.gem 'faker', :version => '0.3.1'
  config.gem 'machinist', :source => 'http://gemcutter.org', :version => '1.0.5'
  config.gem 'haml', :version => '>= 2.0.6'
  config.gem 'rspec', :lib => false, :version => '1.2.9'
  config.gem 'rspec-rails', :lib => false, :version => '1.2.9'
  config.gem 'thoughtbot-shoulda', :lib => false, :source => 'http://gems.github.com', :version => '2.10.2'
  config.gem 'hoptoad_notifier'
  config.gem 'mojombo-chronic', :lib => 'chronic', :version => '0.3.0'
  # config.gem 'chronic'
  config.gem "remarkable_rails", :lib => false
  config.gem "nokogiri", :lib => false
  config.gem 'newrelic_rpm'
  config.gem 'irwi'
  config.gem 'RedCloth'
  config.gem 'erubis'
  config.gem 'tzinfo'
  # config.gem 'BlueCloth'
  # config.gem 'diff-lcs'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :user_observer, :appointment_observer, :presentation_observer, :applicant_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  # config.time_zone = 'UTC'
  config.time_zone = 'Central Time (US & Canada)'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end

Sass::Plugin.options[:template_location] = './app/sass'
Sass::Plugin.options[:css_location] = './public/stylesheets/system'