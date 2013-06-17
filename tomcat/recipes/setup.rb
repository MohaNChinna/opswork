include_recipe 'tomcat::install'
include_recipe 'tomcat::tomcat_env_config'
include_recipe 'tomcat::service'
service 'tomcat' do
  action :restart
end

include_recipe 'apache2'
include_recipe 'apache2::service'
service 'apache2' do
  action :restart
end

include_recipe 'tomcat::apache_tomcat_bind'
