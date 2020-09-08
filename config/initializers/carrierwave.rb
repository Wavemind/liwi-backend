CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIARGDHLEABIW5PPSNA',
    aws_secret_access_key: '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',
    region:                'eu-central-1',
    endpoint:              'https://s3.eu-central-1.amazonaws.com/'
  }
end
