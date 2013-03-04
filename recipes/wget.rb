if node["platform"] != "mac_os_x"
    package "wget"
else
    brew "wget"
end
