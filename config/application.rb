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
    config.active_record.yaml_column_permitted_classes = [ActiveSupport::TimeWithZone, ActiveSupport::TimeZone, Time, Date]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Buenos Aires"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
