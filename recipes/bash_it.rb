bash_it_dir = "#{WS_HOME}/.bash_it"
bash_it_version = version_string_for('bash_it')

git "#{Chef::Config[:file_cache_path]}/bash_it" do
  repository 'http://github.com/revans/bash-it.git'
  revision bash_it_version
  destination "#{Chef::Config[:file_cache_path]}/bash_it"
  action :sync
end

execute "Copying bash-it's .git to #{bash_it_dir}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/bash_it/ #{bash_it_dir}"
  user WS_USER
end

node['bash_it']['enabled_plugins'].each do |type, scripts|
  type_dir    = "#{bash_it_dir}/#{type}"
  enabled_dir = "#{type_dir}/enabled"

  execute "created enabled dir for bash-it #{type}" do
    command "mkdir -p #{enabled_dir}"
    user WS_USER
  end

  scripts.each do |script|
    available_script_path = "#{type_dir}/available/#{script}.#{type}.bash"
    enabled_script_path   = "#{enabled_dir}/#{script}.#{type}.bash"

    execute "enable bash-it #{available_script_path}" do
      command "ln -s #{available_script_path} #{enabled_script_path}"
      user WS_USER
      not_if { ::File.symlink?(enabled_script_path) }
    end
  end
end

node['bash_it']['custom_plugins'].each do |custom_script|
  template "#{bash_it_dir}/custom/#{custom_script}.bash" do
    source custom_script
    owner WS_USER
  end
end
