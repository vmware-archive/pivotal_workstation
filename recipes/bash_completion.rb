Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

include_recipe "pivotal_workstation::bash4"
if node["platform"] != "mac_os_x"
    package "bash-completion"
else
    brew "bash-completion"
end
