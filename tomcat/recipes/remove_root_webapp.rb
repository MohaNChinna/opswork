ruby_block 'remove the ROOT context file' do
  block do
    ::File.delete(::File.join(node['tomcat']['catalina_base_dir'], 'Catalina', 'localhost', 'ROOT.xml'))
  end
  only_if { ::File.file?(::File.join(node['tomcat']['catalina_base_dir'], 'Catalina', 'localhost', 'ROOT.xml')) }
end

ruby_block 'remove the ROOT webapp' do
  block do
    ::FileUtils.rm_rf(::File.join(node['tomcat']['webapps_base_dir'], 'ROOT'), :secure => true)
  end
  only_if { ::File.exists?(::File.join(node['tomcat']['webapps_base_dir'], 'ROOT')) }
  not_if { ::File.symlink?(::File.join(node['tomcat']['webapps_base_dir'], 'ROOT')) }
end
