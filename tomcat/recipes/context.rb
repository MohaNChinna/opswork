node[:deploy].each do |application, deploy|
  template "context file for #{application}" do
    path ::File.join(node['tomcat']['catalina_base_dir'], 'Catalina', 'localhost', "#{application}.xml")
    source 'webapp_context.xml.erb'
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode 0640
    backup false
    only_if { node['datasources'][application] }
    variables(:resource_name => node['datasources'][application], :webapp_name => application)
  end
end
