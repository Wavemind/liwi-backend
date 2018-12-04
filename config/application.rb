require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LiwiBackend
  class Application < Rails::Application

    config.load_defaults 5.2
    config.time_zone = 'Bern'
    config.i18n.default_locale = :en

    # Setup cross-origin
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end

  end
end
