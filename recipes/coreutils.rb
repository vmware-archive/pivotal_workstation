if node["platform"] != "mac_os_x"
    package "coreutils"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "coreutils"
end
