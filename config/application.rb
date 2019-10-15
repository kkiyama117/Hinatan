# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTemplate
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.paths.add 'lib', eager_load: true
    # servicesよりも先にobserversを読み込む必要あり。
    config.paths.add 'observers', eager_load: true
    config.paths.add 'services', eager_load: true
    config.paths.add 'callbacks', eager_load: true
    config.paths.add 'decorators', eager_load: true
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**',
                                                 '*.{rb,yml}').to_s]
    config.i18n.available_locales = %i[ja en]

    # helper を 読み込まないように
    config.action_controller.include_all_helpers = false

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
