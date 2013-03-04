if node["platform"] != "mac_os_x"
    package "siege"
else
    brew "siege"
end
