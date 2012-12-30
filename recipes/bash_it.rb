bash_it_version = version_string_for('bash_it')

git "#{Chef::Config[:file_cache_path]}/bash_it" do
  repository node['bash_it']['repository']
#  revision bash_it_version
  destination "#{Chef::Config[:file_cache_path]}/bash_it"
  action :sync
end

directory node['bash_it']['dir'] do
  owner WS_USER
  mode "0777"
end

execute "Copying bash-it's .git to #{node['bash_it']['dir']}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/bash_it/ #{node['bash_it']['dir']}"
  user WS_USER
end

template node['bash_it']['bashrc_path'] do
  source "bash_it/bashrc.erb"
  cookbook 'pivotal_workstation'
  owner WS_USER
  mode "0777"
end

node['bash_it']['enabled_plugins'].each do |feature_type, features|
  features.each do |feature_name|
    pivotal_workstation_bash_it_enable_feature "#{feature_type}/#{feature_name}"
  end
end

node['bash_it']['custom_plugins'].each do |custom_script_name|
  pivotal_workstation_bash_it_custom_plugin custom_script_name
end
