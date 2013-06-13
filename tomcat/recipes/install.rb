package 'tomcat' do
  package_name "tomcat#{node['tomcat']['base_version']}"
  action :install
end
