service 'tomcat' do
  service_name "tomcat#{node['tomcat']['base_version']}"
  supports :restart => true, :reload => true, :status => true
  action :enable
end
