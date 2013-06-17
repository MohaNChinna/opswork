include_recipe 'tomcat::service'

node[:deploy].each do |application, deploy|
  template "context file for #{application}" do
    path ::File.join(node['tomcat']['catalina_base_dir'], 'Catalina', 'localhost', "#{application}.xml")
    source 'webapp_context.xml.erb'
    owner 'root'
    group 'root'
    mode 0644
    backup false
    variables(:resource_name => node['datasources'][application], :webapp_name => application)
    notifies :restart, resources(:service => 'tomcat')
  end
end
