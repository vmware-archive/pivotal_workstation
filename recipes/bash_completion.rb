include_recipe "pivotal_workstation::bash4"
if node["platform"] != "mac_os_x"
    package "bash-completion"
else
    brew "bash-completion"
end
