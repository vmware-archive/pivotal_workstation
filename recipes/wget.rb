if node["platform"] != "mac_os_x"
    package "wget"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "wget"
end
