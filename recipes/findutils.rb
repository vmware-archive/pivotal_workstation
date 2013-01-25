if node["platform"] != "mac_os_x"
    package "findutils"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "findutils"
end
