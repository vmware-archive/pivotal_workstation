if node["platform"] != "mac_os_x"
    package "bash"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "bash"
end
