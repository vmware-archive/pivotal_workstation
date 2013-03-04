if node["platform"] != "mac_os_x"
    package "findutils"
else
    brew "findutils"
end
