require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChattyCatty
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.autoload_paths << "#{Rails.root}/app/exceptions"
    config.active_record.raise_in_transactional_callbacks = true
    config.jwt_key = ENV["JWT_KEY"] || "super_secret_string"
    config.assets.enabled = false
    config.generators do |g|
      g.assets false
    end
    config.configuration = {
        error_messages: {
            expired_token: "Token has expired",
            token_verification: "Unable to verify Token",
            forbidden: "Forbidden",
            authentication_error: "Authentication Error",
            argument_error: "Argument error",
            record_not_found: "Record not found",
        },
        default_token_exp: 24 * 60 * 60
    }
    config.middleware.delete Rack::Lock
    config.middleware.use FayeRails::Middleware, mount: '/faye', timeout: 25 do
        map '/rooms/**': Chat::RoomsController
    end
  end
end
