if node["platform"] != "mac_os_x"
    package "siege"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "siege"
end
