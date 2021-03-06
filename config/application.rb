require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jtduchesne
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = "Eastern Time (US & Canada)"

    # Internationalization (I18n)
    config.i18n.tap do |i|
      i.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
      i.available_locales = [:en, :fr]
      i.default_locale = :fr
    end

    # Generators
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      
      g.assets false
      g.scaffold_stylesheet false
      
      g.helper_specs false
      g.view_specs   false
      g.system_tests nil
    end
  end
end
