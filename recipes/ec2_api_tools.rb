Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

brew "ec2-api-tools"

pivotal_workstation_bash_it_custom_plugin "ec2_tools-export_paths_and_credentials.bash"
