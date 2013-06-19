include_recipe 'tomcat::service'

node[:deploy].each do |application, deploy|
  context_name = deploy[:mounted_at].blank? ? application : deploy[:mounted_at]

  template "context file for #{application} (context name: #{context_name})" do
    path ::File.join(node['tomcat']['catalina_base_dir'], 'Catalina', 'localhost', "#{context_name}.xml")
    source 'webapp_context.xml.erb'
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode 0640
    backup false
    only_if { node['datasources'][context_name] }
    variables(:resource_name => node['datasources'][context_name], :webapp_name => application)
    notifies :restart, resources(:service => 'tomcat')
  end
end
