default['tomcat']['base_version'] = 6
default['tomcat']['port'] = 8080
default['tomcat']['ajp_port'] = 8009
default['tomcat']['java_options'] = platform?('ubuntu') ? '-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC' : ''
default['tomcat']['catalina_base_dir'] = "/etc/tomcat#{node['tomcat']['base_version']}"
default['tomcat']['lib_dir'] = "/usr/share/tomcat#{node['tomcat']['base_version']}/lib"
default['tomcat']['java_dir'] = '/usr/share/java'
default['tomcat']['mysql_connector_jar'] = 'mysql-connector-java.jar'
default['tomcat']['apache_tomcat_bind_mod'] = 'proxy_http' # or: proxy_ajp
default['tomcat']['apache_tomcat_bind_config'] = 'tomcat_bind.conf'
default['tomcat']['apache_tomcat_bind_path'] = '/tc/'
default['tomcat']['webapps_dir_entries_to_delete'] = %w(config log public tmp)
