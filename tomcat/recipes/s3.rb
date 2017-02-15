s3_file "/tmp/weather_reporting.war" do
  bucket "icp-cf-test"
  remote_path "weather_reporting.war"
  mode '0644'
  action :create
  aws_access_key_id node[:custom_access_key]
  aws_secret_access_key node[:custom_secret_key]
  decryption_key "my SHA256 digest key"
  decrypted_file_checksum "SHA256 hex digest of decrypted file"
end
