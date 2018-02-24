require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Webapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Added to allow html content
    config.action_view.sanitized_allowed_tags = ['h1','h2','h3','h4','h5','strong', 'em', 'a','table','td','tr','thead','tbody','br','ul','li','div','img']
    config.action_view.sanitized_allowed_attributes = ['href', 'title','src','class']
    config.time_zone = "Eastern Time (US & Canada)"
    config.exception_handler = { dev: false }
  end
end
