if node["platform"] == "mac_os_x"
    include_recipe "pivotal_workstation::homebrew"
    brew_install "jpegoptim"
end
