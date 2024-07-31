Rails.application.configure do
  config.active_storage.routes_prefix = '/rails/active_storage'
  config.active_storage.service_urls_expire_in = 5.minutes
  config.active_storage.resolve_model_to_route = :rails_storage_proxy

  # Ensure url_options are set for URL generation
  Rails.application.routes.default_url_options = { host: 'localhost', port: 3000 }
end
