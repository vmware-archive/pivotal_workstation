if node["platform"] != "mac_os_x"
    package "bash"
else
    brew "bash"
end
