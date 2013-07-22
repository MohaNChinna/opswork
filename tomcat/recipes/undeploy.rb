# Copyright 2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not
# use this file except in compliance with the License. A copy of the License is
# located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions
# and limitations under the License.

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  context_name = deploy[:document_root].blank? ? application : deploy[:document_root]
  context_file = ::File.join(node['tomcat']['catalina_base_dir'], 'Catalina', 'localhost', "#{context_name}.xml")

  file context_file do
    action :delete
    only_if { ::File.exists?(context_file) }
  end

  webapp_dir = ::File.join(node['tomcat']['webapps_base_dir'], deploy[:document_root].blank? ? application : deploy[:document_root])

  link webapp_dir do
    action :delete
    only_if { ::File.exists?(webapp_dir) }
  end

  directory "#{deploy[:deploy_to]}" do
    recursive true
    action :delete
    only_if do
      ::File.exists?("#{deploy[:deploy_to]}")
    end
  end

  include_recipe 'tomcat::service'

  execute 'trigger tomcat service restart' do
    command '/bin/true'
    not_if { node['tomcat']['auto_deploy'].to_s == 'true' }
    notifies :restart, resources(:service => 'tomcat')
  end
end
