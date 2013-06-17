include_recipe 'tomcat::install'
include_recipe 'tomcat::tomcat_env_config'
include_recipe 'apache2'
include_recipe 'tomcat::apache_tomcat_bind'
