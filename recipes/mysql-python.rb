Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

include_recipe "pivotal_workstation::mysql"

easy_install_package "MySQL-python"
