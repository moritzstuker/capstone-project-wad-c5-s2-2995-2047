require 'carrierwave/orm/activerecord'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('AWS_BUCKET') # for AWS-side bucket access permissions config, see section below
    config.aws_acl    = 'private'

    # Optionally define an asset host for configurations that are fronted by a
    # content host, such as CloudFront.
    # config.asset_host = 'http://example.com'

    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    # Set custom options such as cache control to leverage browser caching.
    # You can use either a static Hash or a Proc.
    config.aws_attributes = -> { {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
      } }

    config.fog_provider = 'fog/aws'
    config.fog_directory  = ENV.fetch('AWS_BUCKET')
    config.aws_credentials = {
      provider:          'AWS',
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY'),
      secret_access_key: ENV.fetch('AWS_SECRET_KEY'),
      region:            ENV.fetch('AWS_REGION')
    }
  end
end
