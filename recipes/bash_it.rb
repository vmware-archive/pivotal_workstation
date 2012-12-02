::BASH_IT_DIR = ::File.expand_path(".bash_it", WS_HOME)
bash_it_version = version_string_for('bash_it')

git "#{Chef::Config[:file_cache_path]}/bash_it" do
  repository 'http://github.com/revans/bash-it.git'
  revision bash_it_version
  destination "#{Chef::Config[:file_cache_path]}/bash_it"
  action :sync
end

execute "Copying bash-it's .git to #{BASH_IT_DIR}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/bash_it/ #{BASH_IT_DIR}"
  user WS_USER
end

template ::File.expand_path(".bash_it_theme", WS_HOME) do
  source "bash_it/theme.erb"
  owner WS_USER
end

execute "add BASH_IT configuration to .bash_profile" do
  configuration = <<-CONFIGURATION.gsub(/^\s+/, '')
    # START-BASH_IT
    export BASH_IT=$HOME/.bash_it
    source $HOME/.bash_it_theme

    source $BASH_IT/bash_it.sh
    # END-BASH_IT
  CONFIGURATION
  command "echo '#{configuration}' >> #{WS_HOME}/.bash_profile"
  user WS_USER
  not_if "grep 'START-BASH_IT' #{WS_HOME}/.bash_profile"
end

node['bash_it']['enabled_plugins'].each do |feature_type, features|
  features.each do |feature_name|
    pivotal_workstation_bash_it_enable_feature "#{feature_type}/#{feature_name}"
  end
end
