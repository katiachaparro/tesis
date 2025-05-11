require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tesis
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Fix audited bug
    config.active_record.yaml_column_permitted_classes = [ActiveSupport::TimeWithZone, ActiveSupport::TimeZone, Time, Date, BigDecimal]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Buenos Aires"

    # default language i18n
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]
    # config.eager_load_paths << Rails.root.join("extras")

    # Sendgrid configuration
    if ENV['SENDGRID_API_KEY'].present?
      config.action_mailer.default_url_options = { host: ENV['EMAIL_HOST'] }
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.perform_deliveries = true
      config.action_mailer.smtp_settings = {
        address: 'smtp.sendgrid.net',
        port: 587,
        domain: ENV['EMAIL_HOST'],
        user_name: 'apikey',
        password: ENV['SENDGRID_API_KEY'],
        authentication: :plain,
        enable_starttls_auto: true
      }
    end

    # Gmail configuration
    if ENV['MAIL_USERNAME'].present?
      config.action_mailer.default_url_options = { host: ENV['MAIL_HOST'] }
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.perform_deliveries = true
      config.action_mailer.smtp_settings = {
        address: 'smtp.gmail.com',
        port:  ENV['MAIL_PORT'],
        domain: ENV['MAIL_HOST'],
        user_name: ENV['MAIL_USERNAME'],
        password: ENV['MAIL_PASSWORD'],
        authentication: :plain,
        enable_starttls_auto: true
      }
    end
  end
end
