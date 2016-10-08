Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
  {
    :secure_image_url => 'true',
    :image_size => 'original'
  }
end