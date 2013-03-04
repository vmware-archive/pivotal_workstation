if node["platform"] != "mac_os_x"
    package "coreutils"
else
    brew "coreutils"
end
