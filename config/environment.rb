RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.time_zone = 'Brussels'

  config.action_controller.session = {
    :session_key => '_currentversion_session',
    :secret      => 'e940f7192b963fc8684cd12aadcd6fd846cf698bf0c1252a8b727839dc2e254c051fe82e171b600509e4d601ea810be6b8c2cdbbad21e8685b1c44ac8a353ec2'
  }

  config.cache_store = :file_store, "#{RAILS_ROOT}/tmp/cache/"

  config.gem "haml"
end
