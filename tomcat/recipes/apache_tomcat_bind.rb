execute "enable module for apache-tomcat binding" do
  command "/usr/sbin/a2enmod #{node['tomcat']['apache_tomcat_bind_mod']}"
  notifies :restart, resources(:service => 'apache2')
  not_if {::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{node['tomcat']['apache_tomcat_bind_mod']}.load")}
end

template 'tomcat thru apache binding' do
  path "#{node['apache']['dir']}/conf.d/#{node['tomcat']['apache_tomcat_bind_config']}"
  source 'apache_tomcat_bind.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  backup false
  notifies :restart, resources(:service => 'apache2')
end
