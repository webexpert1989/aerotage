require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret '4deeb5221f68c6b4910343846337aff4b7412657cb2e7d95c2f7072aba0bfcad'

  url_format '/media/:sha/:job.:ext'

  response_header 'Cache-Control', 'public, max-age=315360000'

  if Rails.env.development? || Rails.env.test?
    datastore :file,
              root_path: Rails.root.join('public/system/dragonfly', Rails.env),
              server_root: Rails.root.join('public')
  else
    url_host 'http://cdnt.aerotage.com'
    datastore :s3,
              bucket_name: 'aerotagedatadevt',
              access_key_id: 'AKIAIWEJDGPFS3KJPC3A', #ENV['DRAGONFLY_S3_ACCESS_KEY_ID'],
              secret_access_key: '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', #ENV['DRAGONFLY_S3_SECRET_ACCESS_KEY'],
              region: 'us-east-1'
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end