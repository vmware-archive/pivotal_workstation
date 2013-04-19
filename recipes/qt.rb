Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

include_recipe "pivotal_workstation::xquartz"

brew "qt"
