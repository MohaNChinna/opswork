include_recipe 'deploy'
#include_recipe 'dependencies'

node[:deploy].each do |application, deploy|
  target_dir = "#{node['tomcat']['webapps_base_dir']}/xxx"

  directory target_dir
    owner root
    group root
    mode 0775
    action :create
    recursive true
  end

  deploy[:deploy_to] = target_dir
  opsworks_deploy do
    deploy_data deploy
    app application
  end
end
