service 'tomcat' do
  service_name "tomcat#{node['tomcat']['base_version']}"

  if platform?('ubuntu') && node[:platform_version].to_f
    provider Chef::Provider::Service::Upstart
  end

  case node[:platform]
  when 'centos','redhat','fedora','amazon'
    supports :restart => true, :reload => true, :status => true
  when 'debian','ubuntu'
    supports :restart => true, :reload => false, :status => true
  end

  action :enable
end
