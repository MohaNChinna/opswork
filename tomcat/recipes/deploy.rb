include_recipe 'deploy'
#include_recipe 'dependencies'

node[:deploy].each do |application, deploy|
  temp_dir = Dir.mktmpdir(deploy['application']) # TODO: shortname?
  target_dir = "#{node['tomcat']['webapps_base_dir']}/#{deploy['application']}" # TODO: join, shortname?

  directory target_dir do
    owner 'root' # TODO
    group 'tomcat' # TODO
    mode 0775 # TODO?
    action :create
    recursive true
  end

  deploy temp_dir do
    repository deploy[:scm][:repository]
    deploy_to target_dir
    symlinks({})
  end
end
