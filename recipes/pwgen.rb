if node["platform"] != "mac_os_x"
    package "pwgen"
else
    brew "pwgen"
end
