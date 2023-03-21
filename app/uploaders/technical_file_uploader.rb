class TechnicalFileUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(apk)
  end

  # define some uploader specific configurations in the initializer
  # to override the global configuration
  def initialize(*)
    super
    self.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION'],
      endpoint:              'https://s3.eu-central-1.amazonaws.com/'
    }
    self.fog_directory = 'liwi'
  end

  def fog_public
    false
  end

  def fog_authenticated_url_expiration
    15.minutes # in seconds from now,  (default is 10.minutes)
  end
end
