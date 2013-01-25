include_recipe "pivotal_workstation::bash4"
if node["platform"] != "mac_os_x"
    package "bash-completion"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "bash-completion"
end
